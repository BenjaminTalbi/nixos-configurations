# Since we import this module in home.nix we need to add { home-manager.extraSpecialArgs = { inherit inputs; }; } to the modules in flake.nix
{ config, pkgs, inputs, ...  }:

{
  # Do not import the hyprland.homeManagerModules.default here or in home.nix
  # Importing the module will give a infinite recursion error 
  imports = [ ];
    
  #TODO extract  
  home.packages = with pkgs; [ 
    playerctl 
    wl-clipboard 
    grim 
    slurp
    inputs.hyprland-contrib.packages.x86_64-linux.grimblast
    wofi-emoji
    hyprpaper
  ];

  programs.wofi.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = import ./config.nix {};
  };
}
