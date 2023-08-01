{
    description = "NixOS configuration";

    nixConfig = {
      substituters = [ "https://hyprland.cachix.org" ];

      extra-trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    };

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
        #vim-plugins = {
        #    url = "path:./modules/nvim/plugins";
        #    inputs.nixpkgs.follows = "nixpkgs";
        #};
    };

    outputs = inputs@{ self, nur, nixpkgs, home-manager, hyprland, ... }: {
        nixosConfigurations = {
            framework = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
		# pkgs = nixpkgs.legacyPackages.x86_64-linux;
    
	        # Required at least for hyprland and firefox
                specialArgs = { inherit inputs; }; 
	
		modules = [
			./hosts/framework 
            hyprland.nixosModules.default
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
