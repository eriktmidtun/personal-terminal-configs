function fish_prompt
    test $SSH_TTY
    and printf (set_color red)$USER(set_color brwhite)'@'(set_color yellow)(prompt_hostname)' '
    test "$USER" = 'root'
    and echo (set_color red)"#"
    set_color normal
    # https://stackoverflow.com/questions/24581793/ps1-prompt-in-fish-friendly-interactive-shell-show-git-branch
    set -l git_branch (git branch 2>/dev/null | sed -n '/\* /s///p')
    set_color purple
    echo -n "$git_branch "
    echo -n (set_color cyan)(prompt_pwd)
     # Main
    echo -n (set_color red)'❯'(set_color yellow)'❯'(set_color green)'❯ '
end

