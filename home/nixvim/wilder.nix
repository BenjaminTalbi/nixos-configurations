{
  programs.nixvim.plugins.wilder = {
    enable = true;
    modes = [ "/" "?" ":" ];
    renderer = ''
      wilder.popupmenu_renderer(
        wilder.popupmenu_border_theme({
          highlights = {
            border = 'Normal', -- highlight to use for the border
          },
          border = 'rounded',
        })
      )
    '';
  };
}
