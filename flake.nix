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
  };
   
  outputs = inputs@{ self, nixpkgs, home-manager, hyprland, ... }: {
    nixosConfigurations = {
      framework = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; }; 
        modules = [
         ./hosts/framework
         hyprland.nixosModules.default
         { programs.hyprland.enable = true; }
         home-manager.nixosModules.home-manager
         {
           home-manager.useGlobalPkgs = true;
           home-manager.useUserPackages = true;
           home-manager.extraSpecialArgs = { inherit inputs; };
           home-manager.users.benjamin = import ./home;
         } 
        ];
      };
    };
  };
}
