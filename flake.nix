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

    # Wezterm nightly
    wezterm = {
      url = "github:wez/wezterm?dir=nix";
    };

    nixvim = {
      url = "git+file:.?dir=my-nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = inputs@{ self, nur, nixpkgs, home-manager, hyprland, nixos-hardware, ... }: {
    nixosConfigurations = {
      framework = 
      let
        system = "x86_64-linux";
      in
      nixpkgs.lib.nixosSystem {
        inherit system;
        # Required at least for hyprland and firefox
        specialArgs = { inherit inputs; };

        modules = [
          ./hosts/framework
          # Hardware optimizations for framework laptops
          # https://github.com/NixOS/nixos-hardware/blob/master/flake.nix
          nixos-hardware.nixosModules.framework-13th-gen-intel
          
          ./modules/hyprland
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.benjamin = import ./home/default.nix;
            home-manager.extraSpecialArgs = { inherit inputs; inherit system; };
          }
        ];
      };
    };
  };
}
