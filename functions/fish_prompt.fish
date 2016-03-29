function fish_prompt
    set -l status_copy $status
    set -l pwd_info (pwd_info "/")

    if test 0 -eq (id -u $USER) -o ! -z "$SSH_CLIENT"
        echo_color 090 (host_info "host:usr ")
    end

    if pwd_is_home
        echo_color 090 "~/"
    else
        echo_color 090 "/"
    end

    if test ! -z "$pwd_info[2]"
        echo_color 090 "$pwd_info[2]/"
    end

    if test ! -z "$pwd_info[1]"
        echo_color 0f0 "$pwd_info[1]"
    end

    if test ! -z "$pwd_info[3]"
        echo_color 090 "/$pwd_info[3]"
    end

    if set -l branch_name (git_branch_name)
        set -l branch_color 0f0
        set -l branch_status

        if git_is_detached_head
            set branch_color $branch_color -u
        end

        if git_is_touched
            if git_is_staged
                if git_is_dirty
                    set branch_status "+*"
                else
                    set branch_status "+"
                end
            else
                set branch_status "*"
            end
        end

        if git_is_stashed
            set branch_status "$branch_status…"
        end

        echo_color $branch_color " $branch_name"
        echo_color 090 "$branch_status"
    end

    printf " "
end
