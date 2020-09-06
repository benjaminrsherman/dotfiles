function fish_right_prompt
	set_color $fish_color_cwd
	python -c "print($CMD_DURATION / 1000)"
	echo -n "s "
	echo -n -s (prompt_pwd)
end
