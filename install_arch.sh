#!/bin/sh

#### THIS SCRIPT INSTALLS ARCH FROM THE INSTALL DRIVE ####
#### IT ASSUMES YOU'VE ALREADY MOUNTED ALL FILESYSTEMS ###

# Use the fastest mirrors (rankmirrors is in pacman-contrib)
pacman -S --noconfirm pacman-contrib
curl -s "https://www.archlinux.org/mirrorlist/?country=US&protocol=https&ip_version=6" | \
	sed -e 's/^#Server/Server/' -e '/^#/d' | rankmirrors -n 10 > /etc/pacman.d/mirrorlist

# Steam needs the multilib repository
echo "[multilib]"                         >> /etc/pacman.conf
echo "Include = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf

# We're going for a good install, not a minimal install
pacstrap /mnt                                         \
	# Required groups
	base                                                \
	base-devel                                          \
	# Linux
	linux                                               \
	linux-firmware                                      \
	# Networking
	networkmanager                                      \
	# Editors!
	vim                                                 \
	neovim                                              \
	# Shell!
	fish                                                \
	tmux                                                \
	# Documentation
	man-db                                              \
	man-pages                                           \
	texinfo                                             \
	# Graphical environment
	xorg                                                \
	xorg-xinit                                          \
	# i3
	i3-wm                                               \
	i3lock                                              \
	i3status                                            \
	# Programs required for my i3 config
	alacritty                                           \
	dmenu                                               \
	dunst                                               \
	feh                                                 \
	maim                                                \
	unclutter                                           \
	xbacklight                                          \
	# Fonts
	noto-fonts                                          \
	noto-fonts-cjk                                      \
	noto-fonts-emoji                                    \
	ttf-ubuntu-font-family                              \
	# Sound
	pulseaudio                                          \
	pulseaudio-alsa                                     \
	# Vulkan (needed for proton and some games)
	# Does not install drivers (those depend on the graphics card)
	vulkan-icd-loader                                   \
	lib32-vulkan-icd-loader                             \
	# Applications
	discord                                             \
	firefox                                             \
	git                                                 \
	steam                                               \
	steam-native-runtime

genfstab -L /mnt >> /mnt/etc/fstab

cp -r $(dirname ${BASH_SOURCE[0]})/* /mnt/root/dotfiles

arch-chroot /mnt "cd /root/dotfiles; sh setup_arch.sh"
