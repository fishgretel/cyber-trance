function fish_right_prompt
    set -l status_copy $status
    set -l status_code $status_copy

    set -e parts

    function push
        set -g parts $parts $argv
    end

    function seper
        push (cprintf "<fg:#44d>%s</fg>" "|")
    end

    if command -v vcprompt >/dev/null
        set -l vc_prompt (command vcprompt -f '%n:%b %u%m')
        if test ! -z "$vc_prompt"
            seper
            push (cprintf "<fg:#88f>%s</fg>" "$vc_prompt")
            seper
        end
    end

    if command -v python >/dev/null
        if test "$VIRTUAL_ENV" = "$PWD"
            set -l venv (pwd_info " ")
            push (cprintf "<fg:#99e>%s</fg>" "$venv[1]")
            seper
        else if test ! -z "$PYENV_VERSION"
            push (cprintf "<fg:#77e>%s</fg>" "$PYENV_VERSION")
            seper
        end
    end

    # # TODO: not many folks will use gemsets. figure something nicer
    # if test "$GEM_HOME" = "$PWD"
    #     set -l gemh (pwd_info " ")
    #     push (cprintf "<fg:#77e>%s</fg>" "$gemh[1]")
    #     seper
    # end

    switch "$status_copy"
        case "$__cyber_status_last" 0
            set status_code
    end

    set -g __cyber_status_last $status_copy

    if test "$status_copy" -eq 0
        set -e status_copy
    end

    if set -l id (last_job_id -l)
        push (cprintf "<fg:#77e>%s</fg>" "%$id")
        seper
    end

    if test "$CMD_DURATION" -gt 1
        set -l duration (echo $CMD_DURATION | humanize_duration)
        push (cprintf "<fg:#99f>%s</fg>" "$duration")
        seper
    end

    if test ! -z "$status_code"
        push (cprintf "<fg:#ddf>%s</fg><fg:#a00>%s</fg>" "$status_code" "█")
    else
        push (cprintf "<fg:#0e6>%s</fg>" " █")
    end

    for s in $parts
        echo -n $s
    end
end
