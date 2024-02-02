{ pkgs, inputs, ... }:

{
  programs = {
    starship = {
      enable = true;
      settings = { add_newline = true; };
    };
    tmux = {
      enable = true;
      plugins = with pkgs; [
      ];
    };
    kitty = {
      enable = true;
      font.name = "FiraCode Nerd Font";
      shellIntegration.enableBashIntegration = true;
      theme = "Rosé Pine";
    };
    wezterm = {
      enable = true;
      package = inputs.wezterm.packages.${pkgs.system}.default;
      extraConfig = ''
        local config = {}
        if wezterm.config_builder then
          config = wezterm.config_builder()
        end

        config.color_scheme = 'rose-pine'
        config.font = wezterm.font 'FiraCode Nerd Font'
        config.font_size = 16.0
        config.window_background_opacity = 0.9
        config.adjust_window_size_when_changing_font_size = false

        return config
      '';
    };
    bash = {
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
    fish = {
      enable = false;
      interactiveShellInit = '' 
			set fish_greeting # Disable greeting
            set -gx DIRENV_LOG_FORMAT ""
		'';
      plugins = [
        # import with nixpkgs
        { name = "grc"; src = pkgs.fishPlugins.grc.src; }
        { name = "done"; src = pkgs.fishPlugins.done.src; }
        { name = "fzf-fish"; src = pkgs.fishPlugins.fzf-fish.src; }
      ];
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
