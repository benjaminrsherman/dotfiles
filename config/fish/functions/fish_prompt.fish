function fish_prompt
	set_color $fish_color_cwd
	echo -n -s (hostname)': '(basename (prompt_pwd))' $ '
end
