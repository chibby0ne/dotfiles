if status is-interactive
    # Commands to run in interactive sessions can go here
    fish_ssh_agent

    fish_add_path ~/.cargo/bin

    # LS_COLORS is needed to have tree output colorized
    eval (dircolors -c ~/.config/dircolors)

end
