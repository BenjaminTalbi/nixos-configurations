{ inputs, pkgs, ... }:

{
  programs.wezterm = {
    enable = true;
    package = inputs.wezterm.packages.${pkgs.system}.default;
    extraConfig = ''
      local config = {}
      if wezterm.config_builder then
        config = wezterm.config_builder()
      end

      config.color_scheme = 'rose-pine'
      config.font = wezterm.font_with_fallback { 'FiraCode Nerd Font', 'Font Awesome 6 Free' }
      config.font_size = 16.0
      config.window_background_opacity = 0.9
      config.adjust_window_size_when_changing_font_size = false

      return config
    '';
  };
}
