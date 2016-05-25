# https://github.com/fishgretel/cyber-trance
# Copyright (c) 2016 Tom Hensel <github@jitter.eu>
#
function fish_prompt

    # wrapper for comfort
    function push
        set -g parts $parts $argv
    end

    # initialize
    set -e parts
    set -l pwd_info (pwd_info "/")
    set uid (id -u $USER)

    # ssh session? display hostname
    if test ! -z "$SSH_CLIENT"
        push (cprintf "<fg:#ee6>%s</fg>" (host_info "host"))
    end

    # root of all users?
    if test 0 -eq (id -u $USER)
        push (cprintf "<fg:#f77>%s</fg>" (host_info "user|"))
    else
        push (cprintf "<fg:#777>%s</fg>" (host_info "user|"))
    end

    # inside of home directory?
    if pwd_is_home
        push (cprintf "<fg:#66f>%s</fg>" "~/")
    else
        push (cprintf "<fg:#666>%s</fg>" "/")
    end

    # make use of `pwd_info`
    if test ! -z "$pwd_info[2]"
        push (cprintf "<fg:#999>%s</fg>" "$pwd_info[2]/")
    end
    if test ! -z "$pwd_info[1]"
        push (cprintf "<fg:bbb>%s</fg>" "$pwd_info[1]")
    end
    if test ! -z "$pwd_info[3]"
        push (cprintf "<fg:#ccc>%s</fg>" "$pwd_info[3]")
    end

    # what has once been `\$ `
    push (cprintf "<fg:#999>%s</fg>" " ▍ ")

    # iterate over parts and echo each
    for s in $parts
        echo -n $s
    end

end
