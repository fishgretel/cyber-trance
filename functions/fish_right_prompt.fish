# https://github.com/fishgretel/cyber-trance
# Copyright (c) 2016 Tom Hensel <github@jitter.eu>
#
function fish_right_prompt

    # initialize
    set -l status_copy $status
    set -e r_parts

    # settings
    set -l duration_thresh 5000
    set -l vc_prompt_fmt '%n:%b %u %m'
    # set -l vc_prompt_fmt '%n:%b@%r %u %m'
    set -l vc_prompt_timeout 5000

    # wrapper for comfort
    function push
        set -g r_parts $r_parts $argv
    end

    # add seperating element
    function seper
        set -g r_parts $r_parts (cprintf "<fg:#33c>%s</fg>" "|")
    end

    if test "$status_copy" -eq 0
        set -e status_copy
    end

    # inside a virtualenv directory?
    if test ! -z "$DIRENV_DIR"
        seper
        set -l venv (pwd_info " ")
        push (cprintf "<fg:#64a>%s</fg>" "env")
    end

    # python available?
    if command -v python >/dev/null
        # inside a virtualenv directory?
        if test "$VIRTUAL_ENV" = "$PWD"
            set -l venv (pwd_info " ")
            seper
            push (cprintf "<fg:#225>pyve</fg><fg:#66c>%s</fg>" "$venv[1]")
        # nope, but is it managed by pyenv?
        else if test ! -z "$PYENV_VERSION"
            seper
            push (cprintf "<fg:#225>py</fg><fg:#66c>%s</fg>" "$PYENV_VERSION")
        end
    end

    # # TODO: not many folks will use gemsets. figure something nicer
    # if test "$GEM_HOME" = "$PWD"
    #     set -l gemh (pwd_info " ")
    #     seper
    #     push (cprintf "<fg:#77e>%s</fg>" "$gemh[1]")
    # end

    # vcprompt available?
    # TODO: have parser for vcprompt output like pwd_info
    if command -v vcprompt >/dev/null
        # inside a version controlled directory?
        set -l vc_prompt (command vcprompt -t $vc_prompt_timeout -f $vc_prompt_fmt)
        if test ! -z "$vc_prompt"
            # display vcprompt's output
            seper
            push (cprintf "<fg:#77d>%s</fg>" "$vc_prompt")
        end
    end

    # have background job?
    if set -l id (last_job_id -l)
        # display job id
        seper
        push (cprintf "<fg:#88e>%s</fg>" "%$id")
    end

    # last command took more than 1 milisecond?
    if test "$CMD_DURATION" -gt 1
        # make use of `humanize_duration`
        set -l duration (echo $CMD_DURATION | humanize_duration)
        # display duration
        seper
        push (cprintf "<fg:#99e>%s</fg>" "$duration")
    end

    seper

    # how is the status of the last command?
    if test ! -z "$status_copy"
        # not so good, display code
        push (cprintf "<fg:#eef><bg:#c00>%s</bg></fg>" "$status_copy" )
    else
        if test "$CMD_DURATION" -lt 1
            # nothing happened
            push (cprintf "<fg:#669>%s</fg>" "█")
        else if test "$CMD_DURATION" -ge $duration_thresh
            # took a while, alternate color
            push (cprintf "<fg:#fe4>%s</fg>" "█")
        else if test "$CMD_DURATION" -ge 1
            # all lights green, ready to prompt
            push (cprintf "<fg:#0d2>%s</fg>" "█")
        end
    end

    # iterate over parts and echo each
    for s in $r_parts
        echo -n $s
    end

end
