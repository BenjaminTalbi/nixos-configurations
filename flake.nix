{
  description = "NixOS configuration";

  nixConfig = {
    substituters = [
      "https://hyprland.cachix.org" # Cache for Hyprland specifically
      "https://cache.nixos.org" # Cache for everything else
    ];

    trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];

    trusted-users = [ "benjamin" ]; 
  };

  inputs = {
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Needed for some vim plugins (ie. vim-extra-plugins)
    nur.url = "github:nix-community/nur";

    # Needed for Home Manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Needed for Hyprland
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Find a better way, that I actually understand
    tailwind-sorter-nvim = {
      url = "github:laytan/tailwind-sorter.nvim";
      flake = false;
    };
  };

  outputs = inputs@{ self, nur, nixpkgs, home-manager, hyprland, nixos-hardware, ... }: {
    nixosConfigurations = {
      framework = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        # Required at least for hyprland and firefox
        specialArgs = { inherit inputs; };

        modules = [
          ./hosts/framework
          # Hardware optimizations for framework laptops
          # Update to 13 as soon as it is listed here
          # https://github.com/NixOS/nixos-hardware/blob/master/flake.nix
          nixos-hardware.nixosModules.framework-12th-gen-intel

          # Essential for Hyprland. Import it here and not in the module itself!
          hyprland.nixosModules.default

          # Maybe refactor into modules/system.nix
          { programs.hyprland.enable = true; }

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.benjamin = import ./home.nix;
            home-manager.extraSpecialArgs = { inherit inputs; };
          }
        ];
      };
    };
  };
}
