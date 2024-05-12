{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Needed for Home Manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Needed for some vim plugins (ie. vim-extra-plugins)
    nur.url = "github:nix-community/nur";

    # Needed for nixvim managed through home-manager
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    # WSL dependency
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";

    # Needed for blocklist 
    blocklist-hosts.url = "github:StevenBlack/hosts";
    blocklist-hosts.flake = false;

    # Needed for system wide theming
    stylix.url = "github:danth/stylix";

    # WM
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
  };

  outputs = { self, nixpkgs, nixos-wsl, home-manager, stylix, ... }@inputs:
    let
      userSettings = {
        username = "benjamin";
        name = "benjamin";
        email = "b.talbi@live.de";
        term = "foot";
        editor = "vim";
        theme = "everforest";
        font = {
          regular = {
            name = "Iosevka Nerd Font";
            package = (pkgs.nerdfonts.override {
              fonts = [ "Iosevka" ];
            });
          };
          monospace = {
            name = "ZedMono Nerd Font";
            package = (pkgs.nerdfonts.override {
              fonts = [ "ZedMono" ];
            });
          };
        };
      };

      systemSettings = {
        timezone = "Europe/Berlin";
        locale = "en_US.UTF-8";
      };

      extraSpecialArgs = {
        inherit userSettings;
        inherit systemSettings;
        inherit inputs;
      };

      specialArgs = {
        inherit userSettings;
        inherit systemSettings;
        inherit inputs;
      };

      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {

      homeConfigurations = {
        "${userSettings.username}@wodan" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          inherit extraSpecialArgs;

          modules = [
            ./hosts/wodan/home.nix
          ];
        };
        "${userSettings.username}@frija" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          inherit extraSpecialArgs;

          modules = [
            ./hosts/frija/home.nix
          ];
        };
      };

      nixosConfigurations = {
        wodan = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = pkgs.lib.recursiveUpdate specialArgs { systemSettings.hostname = "wodan"; };

          modules = [
            ./hosts/wodan/configuration.nix
            nixos-wsl.nixosModules.wsl
          ];
        };
        frija = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = pkgs.lib.recursiveUpdate specialArgs { systemSettings.hostname = "frija"; };

          modules = [
            ./hosts/frija/configuration.nix
            nixos-wsl.nixosModules.wsl
          ];
        };
      };

    };

  nixConfig = {
    substituters = [
      "https://hyprland.cachix.org" # Cache for Hyprland specifically
      "https://cache.nixos.org" # Cache for everything else
    ];

    trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
  };

}
