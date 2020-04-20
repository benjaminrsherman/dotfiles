if [ -s ~/.config/xmodmap/Xmodmap ]; then
    xmodmap ~/.config/xmodmap/Xmodmap
fi

xset r rate 300 35

unclutter --timeout 1 &

exec i3
