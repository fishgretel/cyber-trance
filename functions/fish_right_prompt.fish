# https://github.com/fishgretel/cyber-trance
# Copyright (c) 2016 Tom Hensel <github@jitter.eu>
#
function fish_right_prompt

    # initialize
    set -l status_copy $status
    set -l drtn_thrshld 5000
    set -l vc_prompt_fmt '%n:%b@%r %u %m'
    set -l vc_prompt_timeout 5000
    set -e r_parts

    # wrapper for comfort
    function push
        set -g r_parts $r_parts $argv
    end

    # add seperating element
    function seper
        set -g r_parts $r_parts (cprintf "<fg:#44d>%s</fg>" "|")
    end

    if test "$status_copy" -eq 0
        set -e status_copy
    end

    # vcprompt available?
    # TODO: have parser for vcprompt output like pwd_info
    if command -v vcprompt >/dev/null
        # inside a version controlled directory?
        set -l vc_prompt (command vcprompt -t $vc_prompt_timeout -f $vc_prompt_fmt)
        if test ! -z "$vc_prompt"
            seper
            # display vcprompt's output
            push (cprintf "<fg:#77f>%s</fg>" "$vc_prompt")
            seper
        end
    end

    # python available?
    if command -v python >/dev/null
        # inside a virtualenv directory?
        if test "$VIRTUAL_ENV" = "$PWD"
            set -l venv (pwd_info " ")
            push (cprintf "<fg:#99e>%s</fg>" "$venv[1]")
            seper
        # nope, but is it managed by pyenv?
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

    # have background job?
    if set -l id (last_job_id -l)
        # display job id
        push (cprintf "<fg:#77e>%s</fg>" "%$id")
        seper
    end

    # last command took more than 1 milisecond?
    if test "$CMD_DURATION" -gt 1
        # make use of `humanize_duration`
        set -l duration (echo $CMD_DURATION | humanize_duration)
        # display duration
        push (cprintf "<fg:#99f>%s</fg>" "$duration")
        seper
    end

    # how is the status of the last command?
    if test ! -z "$status_copy"
        # not so good, display code
        push (cprintf " <fg:#eef><bg:#c00>%s</bg></fg>" "$status_copy" )
    else
        if test "$CMD_DURATION" -lt 1
            # nothing happened
            push (cprintf "<fg:#669>%s</fg>" " █")
        else if test "$CMD_DURATION" -ge $drtn_thrshld
            # took a while, alternate color
            push (cprintf "<fg:#fe4>%s</fg>" " █")
        else if test "$CMD_DURATION" -ge 1
            # all lights green, ready to prompt
            push (cprintf "<fg:#0d2>%s</fg>" " █")
        end
    end

    # iterate over parts and echo each
    for s in $r_parts
        echo -n $s
    end

end
