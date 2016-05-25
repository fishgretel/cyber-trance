function fish_prompt

    set -g pos 0
    set -e parts

    function push
        set -g pos (math $pos+1)
        set -g parts[$pos] $argv
    end

    set -l pwd_info (pwd_info "/")

    set uid (id -u $USER)

    if test ! -z "$SSH_CLIENT"
        push (cprintf "<fg:#ee6>%s</fg>" (host_info "host"))
    end

    if test 0 -eq (id -u $USER)
        push (cprintf "<fg:#f77>%s</fg>" (host_info "user|"))
    else
        push (cprintf "<fg:#777>%s</fg>" (host_info "user|"))
    end

    if pwd_is_home
        push (cprintf "<fg:#66f>%s</fg>" "~/")
    else
        push (cprintf "<fg:#666>%s</fg>" "/")
    end

    if test ! -z "$pwd_info[2]"
        push (cprintf "<fg:#888>%s</fg>" "$pwd_info[2]/")
    end

    if test ! -z "$pwd_info[1]"
        push (cprintf "<fg:#999>%s</fg>" "$pwd_info[1]")
    end

    if test ! -z "$pwd_info[3]"
        push (cprintf "<fg:#aaa>%s</fg>" "$pwd_info[3]")
    end

    push (cprintf "<fg:#999>%s</fg>" " ▍ ")

    for s in $parts
        echo -n $s
    end

end
