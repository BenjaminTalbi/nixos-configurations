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

      rose_pine.selection_fg = '#000000'
      rose_pine.selection_bg = '#907aa9'

        
      config.color_schemes = {
        ['rose-pine-custom'] = rose_pine
      }

      config.color_scheme = 'rose-pine-custom'

      config.font = wezterm.font_with_fallback { 'FiraCode Nerd Font Mono', 'Font Awesome 6 Free' }
      config.font_size = 16.0
      config.window_background_opacity = 0.97
      config.adjust_window_size_when_changing_font_size = false
      config.hide_mouse_cursor_when_typing = true
      
      return config
    '';
  };
}
