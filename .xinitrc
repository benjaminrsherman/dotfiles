if [ -s ~/.Xmodmap ]; then
    xmodmap ~/.Xmodmap
fi

xset r rate 300 35

unclutter -idle 1 &

exec i3
