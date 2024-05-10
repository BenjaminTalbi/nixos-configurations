{ pkgs, ... }:

{
  home.packages = with pkgs; [
    git
    vim
    wget
    curl
    fd
    ripgrep
    fzf
    zip
    unzip
    xz
    jq
    which
    killall
    eza
    bat
    lazygit
    neofetch # I mean... you have to have it, don't you?
  ];
}
