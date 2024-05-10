{ pkgs, ... }:
{
  imports = [
    ./starship.nix
    ./fish.nix
    ./zellij.nix
    ./keychain.nix
  ];

  programs.direnv.enable = true;
  programs.thefuck.enable = true;
  programs.zoxide.enable = true;
  programs.navi.enable = true;
  programs.fzf.enable = true;
  programs.eza.enable = true;
  programs.broot.enable = true;

  home.packages = with pkgs; [ ];

}
