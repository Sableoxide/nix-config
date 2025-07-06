{
  description = "NixOS System Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager , ... }@inputs :
  let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
    username = "sableoxide";
    hostname = "nixos-btw";
  in {
    nixosConfigurations.${hostname} = lib.nixosSystem {
      inherit system;
      modules = [ 
        ./nixos/configuration.nix 
        home-manager.nixosModules.home-manager {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit inputs username hostname; };
              users.${username} = {
                home.backupFileExtension = "backup";
                imports = [./home-manager/home.nix];
              };
            };
        }
      ];
    };
  };
}
