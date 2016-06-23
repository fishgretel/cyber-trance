# https://github.com/fishgretel/cyber-trance
# 2016 Tom Hensel <github@jitter.eu>
#
function fish_prompt

    # wrapper for comfort
    function push
        set -g parts $parts $argv
    end

    # settings
    set -l leveL_symbol '/'
    set -l prompt_symbol '◺ '
    set -l seper_symbol '|'

    # initialize
    set -e parts
    set -l pwd_info (pwd_info "$leveL_symbol")
    set -l uid (id -u $USER)

    # root of all users?
    if test 0 -eq "$uid"
        push (cprintf "<fg:#c77>%s</fg><fg:#844>%s</fg>" (host_info "user") "$seper_symbol")
    else
        push (cprintf "<fg:#669>%s</fg><fg:#448>%s</fg>" (host_info "user") "$seper_symbol")
    end

    # ssh session? display hostname
    if test ! -z "$SSH_CLIENT"
        push (cprintf "<fg:#ee6>%s</fg>" (host_info "host"))
    end

    # inside of home directory?
    if pwd_is_home
        push (cprintf "<fg:#77c>%s%s</fg>" "~" "$leveL_symbol")
    else
        push (cprintf "<fg:#66b>%s</fg>" "$leveL_symbol")
    end

    # make use of `pwd_info`
    if test ! -z "$pwd_info[2]"
        push (cprintf "<fg:#999>%s%s</fg><fg:#66b>%s</fg>" "≈" "$pwd_info[2]" "$leveL_symbol")
    end
    if test ! -z "$pwd_info[1]"
        push (cprintf "<fg:aaa>%s</fg>" "$pwd_info[1]")
    end
    if test ! -z "$pwd_info[3]"
        push (cprintf "<fg:#77b>%s</fg><fg:#ccd>%s</fg>" "$leveL_symbol" "$pwd_info[3]")
    end

    # what has once been `\$ `
    push (cprintf "<fg:#33c>%s</fg>" $prompt_symbol)

    # iterate over parts and echo each
    for s in $parts
        echo -n $s
    end

end
