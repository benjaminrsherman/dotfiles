#!/bin/sh

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

echo "Installing yay..."
git clone https://aur.archlinux.org/packages/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay

echo "Choosing packages..."
cp default_packages packages_to_install
$EDITOR packages_to_install_f
package_list=$(cat packages_to_install | grep -vi '^#' | xargs)
rm packages_to_install

echo "Installing packages..."
yay -Syu --noconfirm $package_list

echo "Setting fish as the default shell..."
chsh -s /usr/bin/fish

echo "Installing configurations..."
sh ${BASH_SOURCE[0]}/install.sh

echo "Setup complete!"
