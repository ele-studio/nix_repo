{
  description = "NixOS Configuration";

  inputs = {
    # NixOS packages - using unstable for latest packages
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Hardware configurations for various devices
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # Home Manager for user configuration
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-hardware, home-manager, ... }@inputs: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          # Hardware configuration
          ./hardware-configuration.nix
          nixos-hardware.nixosModules.framework-13th-gen-intel

          # Main system configuration
          ./configuration.nix

          # Home Manager integration
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "backup";
              users.wesley = import ./home.nix;
              extraSpecialArgs = {
                inherit inputs;
                root = self;
              };
            };
          }
        ];
      };
    };
  };
}
