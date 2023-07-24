{
    description = "NixOS configuration";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        nur.url = "github:nix-community/nur";
        home-manager.url = "github:nix-community/home-manager";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
        hyprland.url = "github:hyprwm/Hyprland";
        hyprland-contrib = {
            url = "github:hyprwm/contrib";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        vim-plugins = {
            url = "path:./modules/nvim/plugins";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = inputs@{ self, nur, vim-plugins, nixpkgs, home-manager, hyprland, ... }: 
        let
            home-linux = { pkgs, lib, ... }:
            {
                nixpkgs.overlays = [ 
                    nur.overlay
                    vim-plugins.overlay 
                ];

                nixpkgs.config = {
                    allowUnfree = true;
                    allowUnfreePredicate = (_: true);
                };
               
                programs.home-manager.enable = true;
                home.stateVersion = "23.05";
                home.homeDirectory = "/home/benjamin";

                imports = [
                    hyprland.homeManagerModules.default
                    { wayland.windowManager.hyprland.enable = true; }
                    .modules/hyprland
                    .modules/nvim
                    .modules/firefox
                    .modules/dunst
                    .modules/waybar
                ];
            };
        in {

        nixosConfigurations = {
            framework = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                modules = [ ./hosts/framework ];
                # Required at least for hyprland
                specialArgs = { inherit inputs; }; 
            };
        };
        homeConfigurations = {
            framework = home-manager.lib.homeManagerConfiguration {
                pkgs = nixpkgs.legacyPackages.x86_64-linux;
                modules = [ home-linux ];
            };

        };
    };
}
