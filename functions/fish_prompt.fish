function fish_prompt
    set -l status_copy $status
    set -l pwd_info (pwd_info "/")

    if test 0 -eq (id -u $USER) -o ! -z "$SSH_CLIENT"
        echo -sn (set_color 090) (host_info "host:usr ") (set_color normal)
    end

    if pwd_is_home
        echo -sn (set_color 090) "~/" (set_color normal)
    else
        echo -sn (set_color 090) "/" (set_color normal)
    end

    if test ! -z "$pwd_info[2]"
        echo -sn (set_color 090) "$pwd_info[2]/" (set_color normal)
    end

    if test ! -z "$pwd_info[1]"
        echo -sn (set_color 0f0) "$pwd_info[1]" (set_color normal)
    end

    if test ! -z "$pwd_info[3]"
        echo -sn (set_color 090) "/$pwd_info[3]" (set_color normal)
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
                    set branch_status "±"
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

        echo -sn " " (set_color $branch_color) "$branch_name" (set_color normal)
        echo -sn (set_color 090) "$branch_status" (set_color normal)
    end

    echo -sn " "
end
