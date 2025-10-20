# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  config,
  lib,
  pkgs,
  ...
}:

let
  languageServerPackages = with pkgs; [
    # go
    gopls
    # python
    pyright
    basedpyright
    uv
    maturin
    # javascript/typescript
    deno
    # lua
    lua-language-server
    luajitPackages.luarocks
    # Rust ls (it requires all 3 of them, since we are not installing using
    # rustup, due to the difficulty of it in nixos)
    rustc
    cargo
    rust-analyzer
    clippy
    # Kotlin
    kotlin-language-server
    #ts
    typescript
    typescript-language-server
    # Nix
    nil
    nixd
    tree-sitter
    # latex
    texlab
    yaml-language-server
    # c/c++
    clang-tools
    # fish
    fish-lsp
  ];

  languagePackages = with pkgs; [
    lua
    gcc
    clang
    typescript
    go
    protobuf
    zulu
    kotlin
    zulu
    glib
  ];

  libraryPackages = with pkgs; [
    libglvnd
  ];

  idePackages = with pkgs; [
    # android-studio
    vscode-fhs
    jupyter-all
    code-cursor
    lmstudio
  ];

  kubernetesPackages = with pkgs; [
    # Containerization/Devops
    minikube
    # If we delete the one downloaded by minikube and
    # add this one then minikube will use this one
    # when selecting --driver=kvm2
    # This is due nixos not being able to run dynamically linked executables
    # as the linker path doesn't exist in NixOS
    # https://github.com/kubernetes/minikube/issues/6023#issuecomment-2103782263
    docker-machine-kvm2
    k3s
    kubernetes-helm
    eksctl
    heroku
    flyctl
    skopeo
    podman
    kubebuilder
    kafkactl
    # awscli2
  ];

  gdk =
    with pkgs;
    google-cloud-sdk.withExtraComponents (with google-cloud-sdk.components; [ gke-gcloud-auth-plugin ]);

  formattersAndBuildToolsPackages = with pkgs; [
    nixfmt-rfc-style
    ruff
    gnumake
    maven
    nodejs
    poetry
    python312Packages.pip
  ];

  databasePackages = with pkgs; [
    sqlite
    dbeaver-bin
    postgresql
  ];

  documentationPackages = with pkgs; [
    man-pages
    man-pages-posix
  ];

  passwordManagersPackages = with pkgs; [
    keepassxc
    _1password-gui
    bitwarden-desktop
  ];

  shellToolsPackages = with pkgs; [
    starship
    bat
    fd
    file
    htop
    jq
    gnupg
    lsof
    ripgrep
    ranger
    slurp
    unzip
    tmux
    tokei
    tree
    wget
    zsh
    nix-index
    yq
    gh
    # Source version control
    git
    gh
    lazygit
    # For taking screenshots and copy pasting
    grim
    wl-clipboard
    neovim
    xxd
    killall
    nushell
    atuin
    fastfetch
    kitty
    wezterm
    ghostty
    android-tools
    neovim-remote
  ];

  videoPackages = with pkgs; [
    obs-studio
    ffmpeg
    mpv
    vlc
    subdl
    yt-dlp
  ];

  audioPackages = with pkgs; [
    pavucontrol
    spotify
    spotube
  ];

  imagePackages = with pkgs; [
    gimp3
    eog
  ];

  socialMediaPackages = with pkgs; [
    telegram-desktop
    tuir
    discord
    slack
    signal-desktop
  ];

  desktopEnvironmentPackages = with pkgs; [
    gammastep
    swaylock
    mako
    bemenu
    wofi
    xfce.thunar
    waybar
    libnotify
    batsignal
    darkman
  ];

  browsersPackages = with pkgs; [
    ladybird
    firefox-devedition
    google-chrome
    lynx
    tor-browser
    brave
  ];

  specialFileViewersPackages = with pkgs; [
    zathura
    kdePackages.okular
    libreoffice-qt-fresh
    typst
    obsidian
    gedit
    # Spell checkers
    hunspell
    hunspellDicts.en-us-large
    calibre
    # imhex
    cherrytree
    taskwarrior3
  ];

  networkingPackages = with pkgs; [
    nmap
    openssl
    wireguard-tools
    qbittorrent
    metasploit
    tor-browser
    rustdesk
    httpie
    protonvpn-gui
    networkmanagerapplet
    iperf
  ];

  hardwareAndDebuggingPackages = with pkgs; [
    acpi
    dmidecode
    # Userspace debugging and diagnostic tool for AMD GPUs
    umr
    usbutils
    power-profiles-daemon
    lshw
    nvme-cli
    s-tui
  ];

  fileSystemsPackages = with pkgs; [
    ntfs3g
    exfat
  ];

  emulatorsPackages = with pkgs; [
    higan
    ares
  ];

  ebpfPackages = with pkgs; [
    bpfmon
    bpftop
    bpftools
    # bpftrace
    linuxHeaders
  ];

in

{
  imports = [
    # Include the results of the hardware scan.
    # From https://github.com/nixos/nixos-hardware
    <nixos-hardware/framework/13-inch/7040-amd>
    ./hardware-configuration.nix
    "${builtins.fetchTarball "https://github.com/nix-community/disko/archive/master.tar.gz"}/module.nix"
    ./disk-config.nix
  ];

  nixpkgs.overlays = [
    (self: super: {
      brave = super.brave.override {
        commandLineArgs = "--password-store=gnome-libsecret";
      };
    })
  ];

  # Use the systemd-boot EFI boot loader.
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 0;
    };
    kernelParams = [
      "console=tty1"
      "amdgpu.dcdebugmask=0x10"
    ];
  };

  # Let's see if this gets rid of the systemd unit?
  services.fprintd = {
    enable = false;
  };

  # Enable CUPS for printing
  services.printing = {
    enable = true;
    # samsung drivers
    drivers = [ pkgs.splix ];
  };

  # enable power saving settings from powertop
  powerManagement.powertop.enable = true;

  # Networking
  networking = {
    hostName = "earth"; # Define your hostname.
    # Pick only one of the below networking options.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    networkmanager.enable = true; # Easiest to use and most distros use this by default.
  };

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    packages = [
      pkgs.terminus_font
    ];
    font = "ter-124n";
    # keyMap = "us";
    useXkbConfig = true; # use xkb.options in tty.
  };

  # Enable Gnome Keyring
  services.gnome.gnome-keyring.enable = true;
  # Attempt unlock keyring upon login
  security.pam.services.gnome.enableGnomeKeyring = true;
  # Enable Seahorse (GUI for Gnome Keyring)
  programs.seahorse.enable = true;

  # XDG Portal
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # Enable sound.
  # https://nixos.wiki/wiki/PipeWire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };
  hardware.bluetooth = {
    enable = true;
    # Enable A2DP sink
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
      };
    };
  };

  # Enabling OpenGL: https://nixos.wiki/wiki/OpenGL
  # This is needed to fix the issue in Python
  # ImportError: libGL.so.1: cannot open shared object file
  hardware.graphics.enable = true;

  # Configure bluetooth for pipewire
  # Wireplumber (services.pipewire.wireplumber) is the default modular session / policy manager for PipeWire
  services.pipewire.wireplumber.configPackages = [
    (pkgs.writeTextDir "share/wireplumber/bluetooth.lua.d/51-bluez-config.lua" ''
      bluez_monitor.properties = {
      ["bluez5.enable-sbc-xq"] = true,
      ["bluez5.enable-msbc"] = true,
      ["bluez5.enable-hw-volume"] = true,
      ["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
      }
    '')
  ];

  # Avoid writing --extra-experimental-features 'nix-command flakes' for certain nix commands
  # https://discourse.nixos.org/t/error-experimental-nix-feature-nix-command-is-disabled/18089/7
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # BIOS updates through LVFS
  services.fwupd.enable = true;

  virtualisation = {
    # Enables libvirtd / kvm2 / qemu virtualization
    libvirtd.enable = true;
    # Enables docker
    docker = {
      enable = true;
      storageDriver = "btrfs"; # Might be needed for btrfs
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.chibby0ne = {
    isNormalUser = true;
    home = "/home/chibby0ne";
    extraGroups = [
      "wheel" # Enable ‘sudo’ for the user.
      "docker" # For using docker without sudo
      "networkmanager" # Enable configuration of network using network manager
      "video" # Required by sway?
      "adbusers" # adb
      "libvirtd" # libvirt / kvm2 driver (minikube)
    ];
  };

  # adb
  programs.adb.enable = true;

  # Accept android sdk license (neccessary for android-studio)
  nixpkgs.config.android_sdk.accept_license = true;

  # Enable automatically regenerate immutable man page index cache
  documentation.man.generateCaches = true;

  # Enable development (libraries and utilities) man pages
  documentation.dev.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages =
    languageServerPackages
    ++ languagePackages
    ++ libraryPackages
    ++ idePackages
    ++ kubernetesPackages
    ++ [ gdk ]
    ++ formattersAndBuildToolsPackages
    ++ databasePackages
    ++ documentationPackages
    ++ passwordManagersPackages
    ++ shellToolsPackages
    ++ videoPackages
    ++ audioPackages
    ++ imagePackages
    ++ socialMediaPackages
    ++ desktopEnvironmentPackages
    ++ browsersPackages
    ++ specialFileViewersPackages
    ++ networkingPackages
    ++ hardwareAndDebuggingPackages
    ++ fileSystemsPackages
    ++ emulatorsPackages
    ++ ebpfPackages;

  programs.nix-ld.enable = true;

  # Install and enable steam
  programs.steam.enable = true;

  # Obsidian, Steam and Discord are unfree
  nixpkgs.config.allowUnfree = true;

  # Enables direnv
  programs.direnv.enable = true;

  # Enables sway
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    xwayland.enable = true;
  };

  # Greeter for sway (starts sway)
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd sway";
        user = "greeter";
      };
    };
  };

  # Enable cron
  services.cron = {
    enable = true;
  };

  programs.fzf = {
    keybindings = true;
    fuzzyCompletion = true;
  };

  # Required for brightness and volume in laptop in sway
  programs.light.enable = true;

  # For Virtualbox
  # virtualisation.virtualbox.host.enable = true;
  # users.extraGroups.vboxusers.members = [ "chibby0ne" ];

  # Fonts
  fonts.packages =
    with pkgs;
    with nerd-fonts;
    [
      iosevka
      iosevka-term
      dejavu-sans-mono

      fira-mono
      fira-code
      zed-mono
      office-code-pro
    ];

  # Fish
  programs.fish.enable = true;
  # Change default shell to zsh for all users
  users.defaultUserShell = pkgs.fish;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?

}
