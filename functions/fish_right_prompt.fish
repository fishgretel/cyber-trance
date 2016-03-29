function fish_right_prompt
    set -l status_copy $status
    set -l status_code $status_copy
    set -l status_color 0f0

    switch "$status_copy"
        case "$status_last" 0
            set status_code
    end

    set -g __cyber_status_last $status_copy

    if test "$status_copy" -ne 0
        set status_color f00
    else
        set -e status_copy
    end

    if test ! -z "$status_code"
        echo_color $status_color "($status_code)  "
    end

    if test "$CMD_DURATION" -gt 100
        set -l duration_copy $CMD_DURATION
        set -l duration (echo $CMD_DURATION | humanize_duration)

        echo_color $status_color "$duration  "

    else if set -l last_job_id (last_job_id)
        echo_color $status_color "%$last_job_id  "
    end

    echo_color -b $status_color " "
end
