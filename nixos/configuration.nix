# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      # From https://github.com/nixos/nixos-hardware
      <nixos-hardware/framework/13-inch/7040-amd>
      ./hardware-configuration.nix
      "${builtins.fetchTarball "https://github.com/nix-community/disko/archive/master.tar.gz"}/module.nix"
      ./disk-config.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use the latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "earth"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    # keyMap = "us";
    useXkbConfig = true; # use xkb.options in tty.
  };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";
  services.xserver.xkb.options = "ctrl:nocaps";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # https://nixos.wiki/wiki/PipeWire
  # sound.enable = true;
  hardware.pulseaudio.enable = false;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  # If you want to use JACK applications, uncomment this
  #jack.enable = true;
  };
  hardware.bluetooth.enable = true;

  
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

  # Enable A2DP sink
  hardware.bluetooth.settings = {
    General = {
      Enable = "Source,Sink,Media,Socket";
    };
  };

  # Have bluetooth headsets take over audio output after connecting
  hardware.pulseaudio.extraConfig = "
    load-module module-switch-on-connect
  ";

  # Avoid writing --extra-experimental-features 'nix-command flakes' for certain nix commands
  # https://discourse.nixos.org/t/error-experimental-nix-feature-nix-command-is-disabled/18089/7
  nix.extraOptions = ''
   experimental-features = nix-command flakes
  '';

  # BIOS updates through LVFS
  services.fwupd.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.chibby0ne = {
    isNormalUser = true;
    home = "/home/chibby0ne";
    extraGroups = [
      "wheel" 			# Enable ‘sudo’ for the user.
      "docker"			# For using docker without sudo
      "networkmanager"		# Enable configuration of network using network manager
      "video"			# Required by sway?
    ]; 
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    acpi
    alacritty
    bat
    bemenu
    blender
    direnv
    discord
    docker
    ffmpeg
    fd
    file
    firefox-devedition
    fwupd
    fzf
    gammastep
    gh
    git
    grim
    gnome.eog
    go
    google-chrome
    home-manager
    htop
    jetbrains.idea-community
    jq
    jupyter-all
    keepassxc
    libgcc
    mako
    maven
    mpv
    neovim
    networkmanager
    nodejs
    obsidian
    oh-my-zsh
    openssl
    pavucontrol
    power-profiles-daemon
    powertop
    pulseaudio
    ranger
    ripgrep
    rocmPackages.llvm.clang
    rocmPackages.llvm.clang-tools-extra

    # bash ls
    nodePackages_latest.bash-language-server

    # lua ls
    lua-language-server

    # Rust ls (it requires all 3 of them, since we are not installing using rustup, due to the difficulty of it in nixos)
    rustc
    cargo
    rust-analyzer

    # go ls
    gopls
    # python ls
    pyright
    # javascript/typescript ls
    deno

    slurp
    sudo
    swaylock
    tmux
    telegram-desktop
    tree
    unzip
    vagrant
    waybar
    wireguard-tools
    wl-clipboard
    wget
    zathura
    zsh
  ];

  # Install and enable steam
  programs.steam = {
    enable = true;
  };

  # Something requires electron25 but it is EOL
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];

  # Obsidian, Steam and Discord are unfree
  nixpkgs.config.allowUnfree = true;


  # Enables docker
  virtualisation.docker.enable = true;
  virtualisation.docker.storageDriver = "btrfs";  # Might be needed for btrfs

  # Enables sway
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };
  # Required for brightness and volume in laptop in sway
  programs.light.enable = true;

  # For Virtualbox
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "chibby0ne" ];

  # For Gnome
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  
  # Do not install these packages
  environment.gnome.excludePackages = (with pkgs; [
  gnome-photos
  gnome-tour
  gedit # text editor
]) ++ (with pkgs.gnome; [
  cheese # webcam tool
  gnome-music
  gnome-terminal
  epiphany # web browser
  geary # email reader
  evince # document viewer
  gnome-characters
  totem # video player
  tali # poker game
  iagno # go game
  hitori # sudoku game
  atomix # puzzle game
]);


  # Fonts
  fonts.packages = with pkgs; [
    nerdfonts
  ];


  # Zsh
  programs.zsh.enable = true;
  # Change default shell to zsh for all users
  users.defaultUserShell = pkgs.zsh;

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

