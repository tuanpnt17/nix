-- Add any additional keymaps here
local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Keymap save all files with Ctrl + s
vim.keymap.set({ "n", "i" }, "<C-s>", function()
  vim.cmd("wa")
end, { desc = "Save all files" })

-- Do things without affecting the registers
keymap.set("n", "x", '"_x')
-- keymap.set("n", "<Leader>p", '"0p')
-- keymap.set("n", "<Leader>P", '"0P')
-- keymap.set("v", "<Leader>p", '"0p')
keymap.set("n", "<Leader>c", '"_c')
keymap.set("n", "<Leader>C", '"_C')
keymap.set("v", "<Leader>c", '"_c')
keymap.set("v", "<Leader>C", '"_C')
keymap.set("n", "<Leader>d", '"_d')
keymap.set("n", "<Leader>D", '"_D')
keymap.set("v", "<Leader>d", '"_d')
keymap.set("v", "<Leader>D", '"_D')

-- Delete backward
keymap.set("n", "db", "vbd", opts)

-- select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Disable continuations
keymap.set("n", "<Leader>o", "o<Esc>^Da", opts)
keymap.set("n", "<Leader>O", "O<Esc>^Da", opts)

-- Split window
keymap.set("n", "sh", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)

-- Redo
keymap.set("n", "U", "<C-r>", opts) -- Redo

keymap.set("n", "L", "$", opts)
keymap.set("v", "L", "$", opts)
keymap.set("n", "H", "0", opts)
keymap.set("v", "H", "0", opts)
