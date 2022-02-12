if [ -s ~/.config/xmodmap/Xmodmap ]; then
    xmodmap ~/.config/xmodmap/Xmodmap
fi

xset r rate 300 35

unclutter --timeout 1 &

eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
export $(gnome-keyring-daemon --start --components=pkcs11,secrets,ssh,gpg)
dbus-update-activation-environment --systemd DISPLAY

exec i3
