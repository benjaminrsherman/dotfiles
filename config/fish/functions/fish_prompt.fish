function fish_prompt
    set_color $fish_color_cwd
    #echo -n -s (hostname)': '(basename (prompt_pwd))' $ '
    echo -n -s 'C:\\'(pwd | sed 's/\//\\\/g')' $ '
end
