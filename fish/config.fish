if status is-interactive
    fish_add_path ~/.cargo/bin
    fish_add_path ~/.wakatime

    set -x EDITOR nvim

    # LANG
    set -x LC_ALL en_US.UTF-8
    set -x LC_CTYPE en_US.UTF-8
    set -x LANG en_US.UTF-8
    # Temperature in Celsius
    set -x LC_MEASUREMENT en_GB.UTF-8

    # Allows the correct rendering of man pages using bat in Linux
    # https://github.com/sharkdp/bat/issues/652#issuecomment-2051790042
    set -x MANROFFOPT -c
    set -x MANPAGER "sh -c 'col -bx | bat -l man --terminal-width 150'"

    # direnv
    direnv hook fish | source

    # Replace ls with eza (CachyOS style)
    alias lt='eza -lht --level=2 --git --icons --sort modified'
    alias l='eza -lh --git --icons --sort modified'
    alias ls='eza -lh --git --icons'
    alias la='eza -lha --git --icons'

    # fish theme (this ghostty current setup)
    # i.e frappe for dark and latte for light (frappe uses latte for light mode))
    # See https://github.com/catppuccin/fish/blob/5fc5ae9c2ec22eb376cb03ce76f0d262a38960f3/README.md?plain=1#L72-L73
    fish_config theme choose catppuccin-frappe

    # remove greeting
    set -g fish_greeting ""

    # starship
    starship init fish | source

    # using fisher for pluging management

end
