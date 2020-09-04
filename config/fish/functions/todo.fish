function todo
    todoist sync
    script -q -c "todoist --color l -f '#Inbox'" /dev/null | cut -f 1,2 -d ' ' --complement
end
