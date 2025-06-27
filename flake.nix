{
  description = "NixOS System Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.05";
    home-manager.url = "github:nix-community/home-manager?ref=release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    nixosConfigurations.nixos-btw = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [ ./nixos/configuration.nix
        home-manager.nixosModules.home-manager {
          home-manager.users.sableoxide = { config, pkgs, ...} : {
            imports = [./home-manager/home.nix];
            backupFileExtension = "backup";
          };
        }
      ];
    };

    homeConfigurations."sableoxide@nixos-btw" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [ ./home-manager/home.nix ];
      extraSpecialArgs = { inherit system; };
    };
  };
}
