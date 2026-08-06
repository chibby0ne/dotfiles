{
  description = "NixOS Configuration flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-2605.url = "github:nixos/nixpkgs?ref=04607e1165ac22c5fde6dcc54c9e0b3c0487c555";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-2605,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
      pinnedPkgs = import nixpkgs-2605 {
        inherit system;
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
            ({ config, pkgs, ... }: {
              nixpkgs.overlays = [
                (final: prev: {
                  xdg-desktop-portal = pinnedPkgs.xdg-desktop-portal;
                })
              ];
            })
          ];
        };
      };
    };
}
