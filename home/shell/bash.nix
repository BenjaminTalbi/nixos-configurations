{ ... }:

{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = ''
      set -o vi
        
      # Silence direnv log. Deactivate if you need to debug
      export DIRENV_LOG_FORMAT=""
        
      alias init-dev="/etc/nixos/scripts/init-dev-shell.sh" 
    '';
  };
}
