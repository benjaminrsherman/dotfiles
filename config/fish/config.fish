thefuck --alias | source

if status is-login
	if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
		sleep 1 # why can't X find the screen without this?
		startx -keeptty
	end
end
