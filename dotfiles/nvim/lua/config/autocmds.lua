-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
vim.opt.autoread = true

-- Tự động kiểm tra khi chuyển buffer hoặc focus vào vim
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
  command = "checktime",
})

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

-- -- Smart input method switch with fcitx5
--
-- -- Hàm kiểm tra bộ gõ có bật không (status = 2 là bật - tiếng Việt)
-- local function is_input_method_on()
--   local f = io.popen("fcitx5-remote")
--   if not f then
--     return false
--   end
--   local status = f:read("*all"):gsub("\n", "")
--   f:close()
--   return status == "2"
-- end
--
-- -- Biến lưu trạng thái bộ gõ khi ở Insert mode
-- local last_insert_im_on = is_input_method_on()
--
-- -- Khi vào Insert mode: nếu trước đó bật bộ gõ → khôi phục lại
-- vim.api.nvim_create_autocmd("InsertEnter", {
--   callback = function()
--     if last_insert_im_on then
--       os.execute("fcitx5-remote -o") -- Bật lại tiếng Việt nếu đang bật trước đó
--     end
--   end,
-- })
--
-- -- Khi rời Insert mode: lưu trạng thái bộ gõ → và luôn chuyển về tiếng Anh
-- vim.api.nvim_create_autocmd("InsertLeave", {
--   callback = function()
--     last_insert_im_on = is_input_method_on()
--     os.execute("fcitx5-remote -c") -- Luôn chuyển về tiếng Anh
--   end,
-- })
--
-- -- Khi vào Cmdline: luôn chuyển về tiếng Anh (gõ lệnh không lỗi)
-- vim.api.nvim_create_autocmd("CmdlineEnter", {
--   callback = function()
--     os.execute("fcitx5-remote -c")
--   end,
-- })
-- -- Khi quay lại Neovim từ ngoài: nếu trước đó đang bật bộ gõ → khôi phục lại
-- vim.api.nvim_create_autocmd("FocusGained", {
--   callback = function()
--     if last_insert_im_on then
--       os.execute("fcitx5-remote -o")
--     end
--   end,
-- })

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
