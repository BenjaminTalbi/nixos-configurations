{ ... }:

{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = ''
      set -o vi
        
      # Silence direnv log. Deactivate if you need to debug
      export DIRENV_LOG_FORMAT=""
        
      # Add ssh keys
      # if [ ! -S ~/.ssh/ssh_auth_sock ]; then
      # eval `ssh-agent`
      # ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
      # fi
      # export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
      # ssh-add -l > /dev/null || ssh-add
    '';
  };
}
