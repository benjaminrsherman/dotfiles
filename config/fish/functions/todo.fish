function todo -a filter
    todoist sync
    if test -z "$filter"
        set filter today
    end
    script -q -c "todoist --color l -f '$filter'" /dev/null | cut -f 1,2,3,4 -d ' ' --complement
end
