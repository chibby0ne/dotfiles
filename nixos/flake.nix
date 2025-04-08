{
  description = "NixOS Configuration flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    oldnixpkgs.url = "github:nixos/nixpkgs?ref=5135c59491985879812717f4c9fea69604e7f26f";
  };

  outputs =
    {
      self,
      nixpkgs,
      oldnixpkgs,
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
      oldpkgs = import oldnixpkgs {
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
            {
              _module.args.oldpkgs = oldpkgs;
            }
          ];
        };
      };
    };

}
