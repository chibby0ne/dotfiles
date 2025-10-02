if status is-interactive
    # Commands to run in interactive sessions can go here
    fish_ssh_agent

    fish_add_path ~/.cargo/bin

    set EDITOR nvim

    # LS_COLORS is needed to have tree output colorized
    eval (dircolors -c ~/.config/dircolors)

    if test (uname) = "Darwin"
        fish_add_path /opt/homebrew/Caskroom/ghostty/1.2.0/Ghostty.app/Contents/MacOS/
        set PAGER "bat"
    else
        set PAGER "bat -p -l man"

    direnv hook fish | source

end
