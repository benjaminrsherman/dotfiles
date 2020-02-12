function fish_prompt
	set_color $fish_color_cwd
    echo -ns (hostname)": "(basename (prompt_pwd))" \$ "
end
