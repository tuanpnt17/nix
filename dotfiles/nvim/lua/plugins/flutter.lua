return {
  'nvim-flutter/flutter-tools.nvim',
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "stevearc/dressing.nvim", -- optional for vim.ui.select
  },

  config = function()
    require("flutter-tools").setup({
      widget_guides = {
        enabled = true,
      },
    })
    -- Set indentation to 2 spaces for Dart/Flutter files
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "dart",
      callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.shiftwidth = 2
        vim.opt_local.softtabstop = 2
        vim.opt_local.expandtab = true
      end,
    })

    -- Keymap
    vim.keymap.set('n', '<leader>flv', function()
      vim.cmd('normal! viw') -- Select word (AppBar)
      vim.cmd('normal! f(')  -- Move to first (
      vim.cmd('normal! %')   -- Select to matching )
      vim.cmd('normal! o')   -- Go back to start of selection
    end, { desc = 'Visual select Widget' })
    -- vim.keymap.set('n', '<leader>fld', ":Telescope flutter commands<Return>", { desc = "Telescope flutter" })
    vim.keymap.set('n', '<leader>flr', ":FlutterRun<CR>", { desc = "Run" })
    vim.keymap.set('n', '<leader>flR', ":FlutterRestart<CR>", { desc = "Restart" })
    vim.keymap.set('n', '<leader>fll', ":FlutterLogToggle<CR>", { desc = "Toggle log" })
    vim.keymap.set('n', '<leader>flc', ":FlutterLogToggle<CR>", { desc = "Clear log" })
    vim.keymap.set('n', '<leader>flo', ":FlutterOutlineToggle<CR>", { desc = "Toggle Outline" })
  end,
}
