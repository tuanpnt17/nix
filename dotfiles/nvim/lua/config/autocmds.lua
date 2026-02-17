vim.opt.autoread = true

-- Filetype-specific settings
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  callback = function()
    vim.bo.shiftwidth = 2
    vim.bo.tabstop = 2
    vim.bo.softtabstop = 2
    vim.bo.expandtab = true
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "cs", "csharp", "java" },
  callback = function()
    vim.bo.shiftwidth = 4
    vim.bo.tabstop = 4
    vim.bo.softtabstop = 4
    vim.bo.expandtab = true
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "MiniFilesBufferCreate",
  callback = function(args)
    local buf_id = args.data.buf_id
    vim.keymap.set("n", "<leader>a", function()
      local entry = require("mini.files").get_fs_entry()
      if entry == nil then
        vim.notify("No fd entry in mini files", vim.log.levels.WARN)
        return
      end
      local target_dir = entry.path
      if entry.fs_type == "file" then
        target_dir = vim.fn.fnamemodify(entry.path, ":h")
      end
      require("easy-dotnet").create_new_item(target_dir)
    end, { buffer = buf_id, desc = "Create file from dotnet template" })
  end,
})
