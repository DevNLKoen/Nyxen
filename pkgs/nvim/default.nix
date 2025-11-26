{pkgs, ...}: {
  vim = {
    extraPackages = [
      pkgs.yazi
    ];
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

    # debugger.nvim-dap.enable = true;
    # debugger.nvim-dap.ui.enable = true;

    ## plugins
    statusline.lualine.enable = true;
    telescope.enable = true;
    autocomplete.blink-cmp.enable = true;

    lsp.enable = true;

    terminal.toggleterm.enable = true;

    # languages
    languages = {
      enableTreesitter = true;
      enableDAP = true;

      nix.enable = true;
      lua.enable = true;
      rust.enable = true;
      python.enable = true;
    };

    filetree.neo-tree.enable = true;

    utility.oil-nvim.enable = true;
    utility.snacks-nvim.enable = true;
    utility.nix-develop.enable = true;
  };
}
