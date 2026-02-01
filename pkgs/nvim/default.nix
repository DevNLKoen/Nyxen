{...}: {
  vim = {
    ## themeing
    theme = {
      enable = true;
      name = "gruvbox";
      style = "dark";
    };

    git.enable = true;

    ## options
    options = {
      smarttab = true;
      shiftwidth = 2;
      tabstop = 4;
      softtabstop = 0;
    };

    runner.run-nvim = {
      enable = true;
    };

    ## plugins
    statusline.lualine.enable = true;
    telescope.enable = true;
    autocomplete.nvim-cmp.enable = true;
    snippets.luasnip.enable = true;

    lsp = {
      enable = true;
      formatOnSave = true;
      lspkind.enable = true;
      inlayHints.enable = true;
    };

    diagnostics.enable = true;

    formatter.conform-nvim.enable = true;

    terminal.toggleterm.enable = true;

    # languages
    languages = {
      enableDAP = true;
      enableExtraDiagnostics = true;
      enableFormat = true;
      enableTreesitter = true;

      java.enable = true;
      lua = {
        enable = true;
        lsp.enable = true;
        treesitter.enable = true;
        format.enable = true;
        extraDiagnostics.enable = true;
      };
      nix.enable = true;
      python.enable = true;
      rust.enable = true;
    };

    filetree.neo-tree.enable = true;

    utility = {
      oil-nvim.enable = true;
      snacks-nvim.enable = true;
      nix-develop.enable = true;
    };
  };
}
