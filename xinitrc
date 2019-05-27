if [ -s ~/.Xmodmap ]; then
    xmodmap ~/.Xmodmap
fi

xset r rate 300 35

exec i3
