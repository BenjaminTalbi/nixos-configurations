{
  programs.nixvim.plugins = {
    lsp = {
      enable = true;
      preConfig = ''
        -- Change the Diagnostic symbols in the sign column (gutter)
        local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end
        

        vim.diagnostic.config {
            virtual_text = true,
            float = {
                header = false,
                border = 'rounded',
                focusable = true,
            }
        }

        vim.lsp.handlers['textDocument/hover'] = vim.lsp.with( vim.lsp.handlers.hover, {border = 'rounded'})
        vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with( vim.lsp.handlers.signature_help, {border = 'rounded'})
      '';
      capabilities = ''
        capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
      '';
      servers = {
        nil_ls = {
          enable = true;
          settings.formatting.command = [ "nixpkgs-fmt" ];
        };
        tsserver.enable = true;
        svelte.enable = true;
        tailwindcss.enable = true;
        cssls.enable = true;
        html.enable = true;
        lua-ls.enable = true;
        emmet_ls = {
          enable = false;
        };
        gopls = {
         enable = true;
        };
      };
      onAttach = ''
        local function map_lsp(description, mode, lhs, rhs)
          local options = { buffer = bufnr, remap = false }
          if description then options = vim.tbl_extend('force', options, { desc = description } ) end
          vim.keymap.set(mode, lhs, rhs, options)
        end

        map_lsp("Show definitions, references", "n", "gR", "<cmd>Telescope lsp_references<CR>")

        map_lsp("Go to declaration", "n", "gd", vim.lsp.buf.definition) 

        map_lsp("Show lsp definitions", "n", "gD", "<cmd>Telescope lsp_definitions<CR>")

        map_lsp("Show lsp implementations", "n", "gi", "<cmd>Telescope lsp_implementations<CR>")

        map_lsp("Show lsp type definitions", "n", "gt", "<cmd>Telescope lsp_type_definitions<CR>")

        map_lsp("See available code actions", {"n", "v"}, "<leader>ca", vim.lsp.buf.code_action)

        map_lsp("Smart rename ", "n", "<leader>rn", vim.lsp.buf.rename)

        map_lsp("Show buffer diagnostics ", "n", "<leader>vD", "<cmd>Telescope diagnostics bufnr=0<CR>")
            
        map_lsp("Show line diagnostics", "n", "<leader>vd", vim.diagnostic.open_float)
        
        map_lsp("Go to next diagnostics", "n", "[d", vim.diagnostic.goto_next)
 
        map_lsp("Go to previous diagnostics", "n", "]d", vim.diagnostic.goto_prev)
          
        map_lsp("Show documentation for what is under the cursor", "n", "K", vim.lsp.buf.hover)

        map_lsp("Restart lsp", "n", "<leader>rs", "<cmd>LspRestart<CR>")
        
        map_lsp("Format buffer", "n", "<leader>fj", vim.lsp.buf.format)
      '';
    };
  };
}
