{
  description = "NixOS Configuration flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-2605.url = "github:nixos/nixpkgs?ref=04607e1165ac22c5fde6dcc54c9e0b3c0487c555";
    nixpkgs-rustdesk.url = "github:nixos/nixpkgs?ref=2fcb964de67fcf60b43471c55d5d99e61a9ccb5a";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-2605,
      nixpkgs-rustdesk,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true; # Obsidian, Steam and Discord are unfree
      };
      pkgs2605 = import nixpkgs-2605 {
        inherit system;
      };
      pkgsRustDesk = import nixpkgs-rustdesk {
        inherit system;
        config.allowUnfree = true;    # uses libsciter which is unfree
      };
    in
    {
      nixosConfigurations = {
        earth = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit system;
          };
          modules = [
            ./nixos/configuration.nix

            # Overlay for xdg-desktop portal so that it installs xdg-desktop-portal 1.20.4
            # There's a regression in 1.22.1 see: https://bbs.archlinux.org/viewtopic.php?id=313883
            # And this: https://github.com/flatpak/xdg-desktop-portal/pull/2027
            # Overlay for rustdesk
            # As it currently 16.08.26 (nixos-unstable branch) has a build failure
            ({ config, pkgs, ... }: {
              nixpkgs.overlays = [
                (final: prev: {
                  xdg-desktop-portal = pkgs2605.xdg-desktop-portal;
                  rustdesk = pkgsRustDesk.rustdesk;
                })
              ];
            })
          ];
        };
      };
    };
}
