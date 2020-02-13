#!/bin/sh

READVALUE=""
read_with_default() {
  prompt=$1
  default=$2
  echo -ns "$prompt "
  if test -Z $default && \
	 test \$default != "__RESPONSE_REQUIRED__" && \
	 test $3 != "NOPRINTDEFAULT"; then
	echo -ns "(default: $default) "
  fi

  read READVALUE
  if test -Z $retval; then
	if test $2 = "__RESPONSE_REQUIRED__"; then
	  echo "Error: This value must be set"
	  read_with_default $1 $2
	elif test -n $default; then
	  READVALUE=$default
	fi
  fi
}

echo -ns "Reading git remote... "
git_remote=$(git remote -v | awk '{print $2}' | head -n 1)
echo "Found $git_remote"

echo -ns "Do you have a non-US keymap? If so, enter it here. "
read keymap
if test -Z $keymap; then
  loadkeys $keymap
fi

read_with_default "What device do you want to install on?" "__RESPONSE_REQUIRED__"
target_device=$READVALUE

# Use sed to simulate an fdisk script to partition the disk
echo "Partioning disk..."
if test -e /sys/firmware/efi/efivars; then
	echo "Detected EFI"
	sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | fdisk $target_device
		g # use a gpt table
		n # new partition
		p # primary partition
		1 # partition number 1
		  # default - start at beginning of the disk
		+100M # 100MB boot partition
		t # change partition type
		1 # change to EFI
		n # new partition
			# default number (2)
			# default start (right after other partition)
			# default end (fill disk)
		p # print partition table
		w # write partition table
		q # exit fdisk
EOF

	read_with_default "What's the name of the main partition?" "${target_device}2"
	main_partition=$READVALUE
	read_with_default "What filesystem would you like on $main_partition" btrfs
	fstype=$READVALUE
	echo "Creating $fstype filesystem on $main_partition..."
	mkfs.$fstype $main_partition
	echo "Mounting $main_partition on /mnt..."
	mount $main_partition /mnt

	read_with_default "What's the name of the boot partition?" "${target_device}1"
	boot_partition=$READVALUE
	echo "Creating FAT32 filesystem on $boot_partition..."
	mkfs.fat -F32 $boot_partition
	echo "Mounting $boot_partition on /mnt/boot..."
	mkdir /mnt/boot
	mount $boot_partition /mnt/boot
else
	echo "Detected BIOS"
	sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | fdisk ${target_device}
		o # use a DOS/MBR table
		n # new partition
		p # primary partition
		1 # partition number 1
		  # default start (first sector)
		  # default end (fill disk)
		p # print partition table
		w # write partition table
		q # exit fdisk
EOF

	read_with_default "What's the name of the main partition?" "${target_device}2"
	main_partition=$READVALUE
	read_with_default "What filesystem would you like on $main_partition" btrfs
	fstype=$READVALUE
	echo "Creating $fstype filesystem on $main_partition..."
	mkfs.$fstype $main_partition
	echo "Mounting $main_partition on /mnt..."
	mount $main_partition /mnt

	mkdir /mnt/boot
fi

echo "Installing pacman-contrib (needed for ranking mirrors)..."
pacman -S --noconfirm pacman-contrib
echo "Finding fast mirrors..."
curl -s "https://www.archlinux.org/mirrorlist/?country=US&protocol=https&ip_version=6" | \
	sed -e 's/^#Server/Server/' -e '/^#/d' | rankmirrors -n 10 > /etc/pacman.d/mirrorlist

echo "Installing basic requirements..."
# Just install minimal requirements here
pacstrap /mnt                          \
    # Required groups
    base                               \
    base-devel                         \
    # Linux
    linux                              \
    linux-firmware                     \
    # Networking
    networkmanager                     \
    # Editor
    vim                                \
    # Needed so we can pull the updates
    git

echo "Generating fstab..."
genfstab -L /mnt >> /mnt/etc/fstab

echo "Chrooting into installed system..."
# NOTE: We have to escape the dollar signs, otherwise
# the shell would try to substitute them before sending
# the lines into arch-chroot
arch-chroot /mnt << EOF
READVALUE=""
read_with_default() {
  prompt=\$1
  default=\$2
  echo -ns "\$prompt "
  if test -Z \$default && \
     test \$default != "__RESPONSE_REQUIRED__" && \
	 test \$3 != "NOPRINTDEFAULT"; then
	echo -ns "(default: \$default) "
  fi

  read READVALUE </dev/tty
  if test -Z \$retval; then
	if test \$2 = "__RESPONSE_REQUIRED__"; then
	  echo "Error: This value must be set"
	  read_with_default \$1 \$2
	elif test -n \$default; then
	  READVALUE=\$default
	fi
  fi
}

read_yn() {
  while :; do
	read_with_default "\$1 (Y/n)" Y NOPRINTDEFAULT
	READVALUE=\$(echo \$READVALUE | awk '{print tolower(\$0)}')
	if test \$READVALUE = 'y' || test \$READVALUE = 'n'; then
	  break
	fi
  done
}

read_with_default "What is your timezone?" "US/Eastern"
tzone=\$READVALUE
echo "Setting timezone to \$tzone"
ln -sf /usr/share/zoneinfo/\$tzone /etc/localtime

read_with_default "What locales should be generated? Separate with spaces." "en_US.UTF-8"
locales=\$READVALUE
if test -z \$locales; then
  locales="en_US.UTF-8"
fi
for locale in \$locales; do
  sed -i 's/^#\$locale/\$locale/g' /etc/locale.gen
done
locale-gen

read_with_default "What should LANG be set to?" "\$(echo \$locales | awk '{print \$1}')"
echo "LANG=\$READVALUE" > /etc/locale.conf

if test -Z $keymap; then
  echo "KEYMAP=$keymap" > /etc/vconsole.conf
fi

read_with_default "What should the hostname be?" __RESPONSE_REQUIRED__
hname=\$READVALUE
echo \$hname > /etc/hostname

rm /etc/hosts # In case someone's screwing with us
echo "127.0.0.1  localhost"                   >> /etc/hosts
echo "::1        localhost"                   >> /etc/hosts
echo "127.0.0.1  \$hname.localdomain \$hname" >> /etc/hosts

read_yn "Do you want to set up a default user?"
gen_user=\$READVALUE

if test \$gen_user = 'y'; then
  read_with_default "What should the username be?" __RESPONSE_REQUIRED__
  usrname=\$READVALUE

  echo "Creating user \$usrname..."
  useradd -m \$usrname
  echo "Please enter a password for \$usrname..."
  passwd \$username </dev/tty

  echo "Giving \$usrname sudo permissions..."
  echo "\$usrname ALL=(ALL) ALL" >> /etc/sudoers

  read_yn "Do you want to give \$usrname Ben's defaults?"
  setup_ben=\$READVALUE

  if test \$setup_ben = 'y'; then
	echo "Cloning dotfiles repository into /home/\$usrname/.dotfiles..."
	git clone $git_remote /home/\$usrname/.dotfiles

	echo "Giving \$usrname ownership of their home directory"
	chown -R \$usrname:\$usrname /home/\$usrname

	echo "Transferring control to /home/\$usrname/setup_arch.sh"
	EDITOR=/usr/bin/vim runuser \$usrname sh ./setup_arch.sh < /dev/tty
  fi

  echo "User setup complete!"
fi

read_yn "Do you want to set up GRUB?"
install_grub=\$READVALUE

if test \$install_grub = 'y'; then
  if test -e /sys/firmware/efi/efivars; then
	echo "Installing GRUB for an EFI system..."
	pacman -S --noconfirm grub efibootmgr
	grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
  else
	echo "Installing GRUB for a BIOS system..."
	pacman -S --noconfirm grub
	grub-install --target=i386-pc $target_device
  fi

  read_yn "Do you want to remove the GRUB timeout?"
  remove_grub_timeout=\$READVALUE
  if test \$remove_grub_timeout = 'y'; then
	sed -i 's/^GRUB_TIMEOUT=\d/GRUB_TIMEOUT=0/g' /etc/default/grub
  fi

  echo "Generating grub configuration..."
  grub-mkconfig -o /boot/grub/grub.cfg
fi

echo "Chroot install complete!"
EOF

echo "Install complete!"
