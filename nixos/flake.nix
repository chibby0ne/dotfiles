{
  description = "NixOS Configuration flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-obsidian.url = "github:nixos/nixpkgs?ref=nixos-26.05";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-obsidian,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true; # Obsidian, Steam and Discord are unfree
      };
      pkgsObsidian = import nixpkgs-obsidian {
        inherit system;
        config.allowUnfree = true; # Obsidian, Steam and Discord are unfree
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
                  obsidian = pkgsObsidian.obsidian;
                })
              ];
            })
          ];
        };
      };
    };
}
