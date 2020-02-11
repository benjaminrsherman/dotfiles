#!/bin/sh

#### THIS IS TO SET UP MY ARCH INSTALL ####
####  IF YOU JUST WANT THE DOTFILES,   ####
####         USE install.sh            ####

## INTENDED TO BE RUN AS ROOT IN CHROOT  ##

if test -n $1; then
	hostname=$1
else
	hostname="valkyrie"
fi

username=benjamin # CHANGE THIS IF NEEDED

# Set up timezone
ln -sf /usr/share/zoneinfo/US/Eastern /etc/localtime
hwclock --systohc

# Set locales
sed -i 's/^#en_US\.UTF-8$/en_US.UTF-8' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo $hostname > /etc/hostname

echo "127.0.0.1    localhost"                       >> /etc/hosts
echo "::1          localhost"                       >> /etc/hosts
echo "127.0.1.1    $hostname.localdomain $hostname" >> /etc/hosts

# Set up my user
useradd -m $username
echo "$username ALL=(ALL) ALL" >> /etc/sudoers
mkdir /home/$username/dotfiles
cp -r $(dirname ${BASH_SOURCE[0]})/* /home/$username/dotfiles

# Run dotfiles install script as the end user
runuser $username -c "sh /home/$username/dotfiles/install.sh"

chsh -s /usr/bin/fish $username

# Install yay
git clone https://aur.archlinux.org/packages/yay.git ~/yay
cd ~/yay
makepkg -si
cd ..
rm -rf yay
