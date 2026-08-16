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
    delve
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
    # java
    jdt-language-server
    # Kotlin
    kotlin-language-server
    #ts
    typescript
    typescript-language-server
    bun
    deno
    # Nix
    nil
    nixd
    # latex
    texlab
    yaml-language-server
    # c/c++
    clang-tools
    # fish
    fish-lsp
    # zig
    # zls broken at the moment in unstable
    # scheme
    akkuPackages.scheme-langserver
    # haskell
    haskell-language-server
  ];

  languagePackages = with pkgs; [
    dart
    flutter
    lua
    gcc
    clang
    clang-manpages
    bear
    sbcl
    ghc
    cabal-install
    typescript
    go
    protobuf
    zulu
    maven
    gradle
    kotlin
    zulu
    glib
    zig
    python314
    chez
  ];

  libraryPackages = with pkgs; [
    libglvnd
  ];

  idePackages = with pkgs; [
    android-studio
    vscode-fhs
    jetbrains.idea
    claude-monitor
    opencode
  ];

  pythonPackages = with pkgs.python314Packages; [
    ipython
    jupyterlab
  ];

  kubernetesPackages = with pkgs; [
    # Containerization/Devops
    minikube
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
    nixfmt
    ruff
    gnumake
    maven
    nodejs
  ];

  databasePackages = with pkgs; [
    sqlite
    dbeaver-bin
    postgresql
  ];

  documentationPackages = with pkgs; [
    man-pages
    man-pages-posix
    graphviz
    calibre
    yacreader
  ];

  passwordManagersPackages = with pkgs; [
    keepassxc
  ];

  shellToolsPackages = with pkgs; [
    bash
    starship
    bat
    fd
    eza
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
    tectonic
    fw-ectool
  ];

  videoPackages = with pkgs; [
    obs-studio
    ffmpeg
    mpv
    vlc
    subdl
    yt-dlp
    stellarium
  ];

  audioPackages = with pkgs; [
    pavucontrol
    spotify
    spotube
  ];

  imagePackages = with pkgs; [
    gimp3
    eog
    pinta
    xournalpp
  ];

  socialMediaPackages = with pkgs; [
    telegram-desktop
    discord
    signal-desktop
  ];

  desktopEnvironmentPackages = with pkgs; [
    gammastep
    swaylock
    mako
    bemenu
    wofi
    thunar
    waybar
    libnotify
    batsignal
    darkman
    conky
  ];

  browsersPackages = with pkgs; [
    # ladybird
    firefox-devedition
    google-chrome
    lynx
    tor-browser
    brave
    googleearth-pro
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
    # calibre
    imhex
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
    networkmanagerapplet
    iperf
  ];

  hardwareAndDebuggingPackages = with pkgs; [
    acpi
    dmidecode
    # Userspace debugging and diagnostic tool for AMD GPUs
    umr
    usbutils
    lshw
    nvme-cli
    s-tui
    kdePackages.wacomtablet
  ];

  fileSystemsPackages = with pkgs; [
    ntfs3g
    exfat
  ];

  emulatorsPackages = with pkgs; [
    ares
    dualsensectl
  ];

  ebpfPackages = with pkgs; [
    bpfmon
    bpftop
    bpftools
    bpftrace
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

  #-------------------------------------------------------
  # Boot options
  #-------------------------------------------------------
  boot = {
    # Use the systemd-boot EFI boot loader.
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 12;
      };
      efi.canTouchEfiVariables = true;
      timeout = 0;
    };
    kernelParams = [
      "console=tty1"
      "amdgpu.dcdebugmask=0x10"
    ];
    kernelPackages = pkgs.linuxPackages_latest;
    enableContainers = true;      # Enable nixos containers, these are systemd-nspawn containers
  };

  #-------------------------------------------------------
  # Hardware options
  #-------------------------------------------------------
  hardware = {
    bluetooth = {
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
    graphics.enable = true;

    # Required for brightness and volume in laptop in sway
    brillo.enable = true;
  };

  #-------------------------------------------------------
  # Networking options
  #-------------------------------------------------------
  networking = {
    hostName = "earth"; # Define your hostname.
    # Pick only one of the below networking options.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    networkmanager = {
      enable = true; # Easiest to use and most distros use this by default.
    };
  };

  #-------------------------------------------------------
  # Security options
  #-------------------------------------------------------
  security = {
    # Enable sound.
    # https://nixos.wiki/wiki/PipeWire
    rtkit.enable = true;
    # Attempt unlock keyring upon login
    pam.services.gnome.enableGnomeKeyring = true;
  };

  #-------------------------------------------------------
  # Virtualization options
  #-------------------------------------------------------
  virtualisation = {
    # Enables libvirtd / kvm2 / qemu virtualization
    libvirtd.enable = true;
    # Enables docker
    docker = {
      enable = true;
      storageDriver = "btrfs"; # Might be needed for btrfs
    };
  };

  #-------------------------------------------------------
  # nix options
  #-------------------------------------------------------
  nix = {
    # automatic garbage collection (nix-collect-garbage --delete-older-than 20d weekly)
    # https://nixos.org/guides/nix-pills/11-garbage-collector.html
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 20d";
    };
    # automatic store optimization (run nix store optimizer weekly)
    # https://nixos.wiki/wiki/Storage_optimization
    optimise = {
      automatic = true;
      dates = [ "weekly" ];
    };
    settings.auto-optimise-store = true;
    # Avoid writing --extra-experimental-features 'nix-command flakes' for certain nix commands
    # https://discourse.nixos.org/t/error-experimental-nix-feature-nix-command-is-disabled/18089/7
    extraOptions = ''experimental-features = nix-command flakes'';
  };

  #-------------------------------------------------------
  # Internationalization options
  #-------------------------------------------------------
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_MEASUREMENT = "en_GB.UTF-8";
    };
  };
  console = {
    packages = [
      pkgs.terminus_font
    ];
    font = "${pkgs.terminus_font}/share/consolefonts/ter-124n.psf.gz";
    keyMap = "us";
  };

  #-------------------------------------------------------
  # xdg portal options
  #-------------------------------------------------------
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  #-------------------------------------------------------
  # Documentation options
  #-------------------------------------------------------
  documentation = {
    # Enable automatically regenerate immutable man page index cache
    man.cache.enable = true;
    # Enable development (libraries and utilities) man pages
    dev.enable = true;
  };

  #-------------------------------------------------------
  # Programs options
  #-------------------------------------------------------
  programs = {
    # Seahorse (GUI for Gnome Keyring)
    seahorse.enable = true;

    # Java
    java.enable = true;

    # Wireshark
    wireshark = {
    enable = true;
    dumpcap.enable = true;
    };

    # Browser to log in to captive portals without messing with DNS settings
    captive-browser = {
      enable = true;
      interface = "wlp1s0";
    };

    # nix-ld (Enables running unpatched by nixos, dynamic elf binaries (e.g:
    # third party package managers downloaded: pip, mason, npm, etc..)
    nix-ld.enable = true;

    # Steam
    steam.enable = true;

    # Direnv
    direnv.enable = true;

    # Sway
    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
      xwayland.enable = true;
    };

    # fzf
    fzf = {
      keybindings = true;
      fuzzyCompletion = true;
    };

    # Ausweisapp
    ausweisapp = {
      enable = true;
      openFirewall = true;
    };

    # Fish
    fish.enable = true;
  };

  # List of packages installed for all users
  environment.systemPackages =
    languageServerPackages
    ++ languagePackages
    ++ libraryPackages
    ++ idePackages
    ++ pythonPackages
    ++ kubernetesPackages
    # ++ [ gdk ]
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

  #-------------------------------------------------------
  # nixpkgs options
  #-------------------------------------------------------
  nixpkgs = {
    overlays = [
      (self: super: {
        brave = super.brave.override {
          commandLineArgs = "--password-store=gnome-libsecret";
        };
      })
    ];

    config = {
      # Accept android sdk license (neccessary for android-studio)
      android_sdk.accept_license = true;
      # Obsidian, Steam and Discord are unfree
      allowUnfree = true;
      permittedInsecurePackages = [ "googleearth-pro-7.3.7.1155" ];
    };
  };

  #-------------------------------------------------------
  # Services options
  #-------------------------------------------------------
  services = {
    # Enable Gnome Keyring
    gnome.gnome-keyring.enable = true;

    # Let's see if this gets rid of the systemd unit?
    fprintd.enable = false;

    # Enable CUPS for printing
    printing = {
      enable = true;
      # samsung drivers
      drivers = [
        pkgs.splix
        pkgs.cups-filters
      ];
    };

    # mullvad
    resolved.enable = true;
    mullvad-vpn = {
      enable = true;
      gui.enable = true;
    };

    # Configure bluetooth for pipewire
    # Wireplumber (services.pipewire.wireplumber) is the default modular session / policy manager for PipeWire
    pipewire.wireplumber.configPackages = [
      (pkgs.writeTextDir "share/wireplumber/bluetooth.lua.d/51-bluez-config.lua" ''
        bluez_monitor.properties = {
        ["bluez5.enable-sbc-xq"] = true,
        ["bluez5.enable-msbc"] = true,
        ["bluez5.enable-hw-volume"] = true,
        ["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
        }
      '')
    ];

    # BIOS updates through LVFS
    fwupd.enable = true;

    # Greeter for sway (starts sway)
    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd sway";
          user = "greeter";
        };
      };
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;
    };

    cron.enable = true;

    # enable xserver, i3 and other packages
    xserver = {
      enable = true;
      windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [
          dmenu
          i3status
        ];
      };
      # Need startx in order to start i3 without a graphical display manager (currently using greetd/tuigreet)
      displayManager.startx.enable = true;
      # Enable wacom digitizer/tablet
      wacom.enable = true;
    };
  };

  #-------------------------------------------------------
  # Fonts options
  #-------------------------------------------------------
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

  #-------------------------------------------------------
  # Time options
  #-------------------------------------------------------
  time.timeZone = "Europe/Berlin";

  #-------------------------------------------------------
  # users options
  #-------------------------------------------------------
  users = {
    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.chibby0ne = {
      isNormalUser = true;
      home = "/home/chibby0ne";
      extraGroups = [
        "wheel" # Enable ‘sudo’ for the user.
          "networkmanager" # Enable configuration of network using network manager
          "video" # Required by sway?
          "adbusers" # adb
          "libvirtd" # libvirt / kvm2 driver (minikube)
          "wireshark" # wireshark
      ];
    };

    # Change default shell to zsh for all users
    defaultUserShell = pkgs.fish;
  };

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
