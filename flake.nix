{
description = "HiboMan's Configuration Flake";

inputs = {
  nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  home-manager = {
    url = "github:nix-community/home-manager";
    inputs.nixpkgs.follows = "nixpkgs";
  };
};

outputs = {
  self,
  nixpkgs,
  ...
} @ inputs: let

  pkgs = nixpkgs.legacyPackages."x86_64-linux";
in {

  devShells."x86_64-linux".default = pkgs.mkShell {
  };

  nixosConfigurations = {
    nixos = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./configuration.nix
        inputs.home-manager.nixosModules.default
      ];
    };
  };
 };
}
