{
  programs.nixvim.plugins = {
    cmp = {
      enable = true;
      settings = {
        mapping = {
          "<C-k>" = "cmp.mapping.select_prev_item()";
          "<C-j>" = "cmp.mapping.select_next_item()";
          "<C-e>" = "cmp.mapping.complete()"; # Show completion suggestions
          "<CR>" = "cmp.mapping.confirm({ select = true })";
          "<C-n>" = "cmp.mapping.scroll_docs(4)";
          "<C-p>" = "cmp.mapping.scroll_docs(-4)";
        };
        window.completion.border = [ "╭" "─" "╮" "│" "╯" "─" "╰" "│" ];
        completion.completeopt = "menu,menuone,noselect,preview";
        sources = [
          { name = "nvim_lsp"; }
          { name = "luasnip"; }
          { name = "buffer"; }
          { name = "path"; }
        ];
        snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";
      };
    };
    cmp-buffer.enable = true;
    cmp-path.enable = true;
    cmp_luasnip.enable = true;
    luasnip.enable = true;
    # friendly-snippets = true;
    cmp-nvim-lsp-signature-help.enable = true;
  };
}
