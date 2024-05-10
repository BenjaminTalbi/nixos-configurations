{ pkgs, lib, ... }:

{
  programs.fish = {
    enable = true;
    
  };
  
  # cd replacement that remembers
  programs.zoxide.enableFishIntegration = true;
  # Cache secrets
  services.gpg-agent.enableFishIntegration = true; 
  # Tmux alternative
  programs.zellij.enableFishIntegration = true;
  # Write 'fuck' to correct misspelled commands
  programs.thefuck.enableFishIntegration = true; 
  # Super charged prompt
  programs.starship.enableFishIntegration = true;
  # Cheat sheet for one-liners (ctrl+g)
  programs.navi.enableFishIntegration = true;
  # Password prompt for ssh keys. Keeps them loaded
  programs.keychain.enableFishIntegration = true;
  # It's fzf 
  programs.fzf.enableFishIntegration = true;
  # eza is the new exa which was the new ls
  programs.eza.enableFishIntegration = true;
  # Tree based file explorer?
  programs.broot.enableFishIntegration = true;

 
}
