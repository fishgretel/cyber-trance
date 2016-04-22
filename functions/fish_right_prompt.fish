function fish_right_prompt
    set -l status_copy $status
    set -l status_code $status_copy
    set -l status_color 090

    switch "$status_copy"
        case "$__cyber_status_last" 0
            set status_code
    end

    set -g __cyber_status_last $status_copy

    if test "$status_copy" -ne 0
        set status_color c00
    else
        set -e status_copy
    end

    if test ! -z "$status_code"
        echo -sn (set_color $status_color) "($status_code)  " (set_color normal)
    end

    if test "$CMD_DURATION" -gt 100
        set -l duration (echo $CMD_DURATION | humanize_duration)
        echo -sn (set_color $status_color) "$duration  " (set_color normal)

    else if set -l id (last_job_id -l)
        echo -sn (set_color $status_color) "%$id  " (set_color normal)
    end

    echo -sn (set_color -b $status_color) " " (set_color normal)
end
