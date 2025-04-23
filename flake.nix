{
  description = "HiboMan's Configuration Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
   # stylix.url = "github:danth/stylix";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
   # home-manager = {
   #   url = "github:nix-community/home-manager";
   #   inputs.nixpkgs.follows = "nixpkgs";
   # };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./configuration.nix
         # inputs.nixvim.nixosModules.nixvim
         # inputs.home-manager.nixosModules.default
         # inputs.stylix.nixosModules.stylix
        ];
      };
    };
  };
}
