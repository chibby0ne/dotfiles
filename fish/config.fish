if status is-interactive
    # Commands to run in interactive sessions can go here
    fish_ssh_agent

    fish_add_path ~/.cargo/bin

    set -x EDITOR nvim

    # LANG
    set -x LC_ALL en_US.UTF-8
    set -x LC_CTYPE en_US.UTF-8
    set -x LANG en_US.UTF-8
    # Temperature in Celsius
    set -x LC_MEASUREMENT en_GB.UTF-8

    # LS_COLORS is needed to have tree output colorized
    eval (dircolors -c ~/.config/dircolors)

    if test (uname) = Darwin
        fish_add_path /opt/homebrew/Caskroom/ghostty/1.2.0/Ghostty.app/Contents/MacOS/
        set -x PAGER bat
    else
        set -x PAGER "bat -p -l man"
    end

    direnv hook fish | source

end
