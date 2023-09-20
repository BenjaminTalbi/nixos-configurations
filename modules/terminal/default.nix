{ pkgs, ... }:

{
  programs = {
    starship = {
      enable = true;
      settings = { add_newline = true; };
    };
    wezterm = {
      enable = true;
      extraConfig = ''
        local config = {}
        if wezterm.config_builder then
          config = wezterm.config_builder()
        end

        config.color_scheme = 'rose-pine'
        config.font = wezterm.font 'FiraCode Nerd Font'
        config.window_background_opacity = 0.9
        config.adjust_window_size_when_changing_font_size = false

        return config
      '';
    };
    fish = {
      enable = true;
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
