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

        local rose_pine = wezterm.color.get_builtin_schemes()['rose-pine']

        rose_pine.copy_mode_active_highlight_bg = { Color = '#ebbcba' }
        rose_pine.copy_mode_active_highlight_fg = { Color = '#21202e' }
        rose_pine.copy_mode_inactive_highlight_bg = { Color = '#524f67' }
        rose_pine.copy_mode_inactive_highlight_fg = { Color = '#21202e' }

        config.color_scheme = 'rose-pine'

        config.font = wezterm.font_with_fallback { 'FiraCode Nerd Font', 'Font Awesome 6 Free' }
        config.font_size = 16.0
        config.window_background_opacity = 0.97
        config.adjust_window_size_when_changing_font_size = false
      
        return config
    '';
  };
}
