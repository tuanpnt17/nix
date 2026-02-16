return {
  "stevearc/oil.nvim",
  dependencies = { { "nvim-tree/nvim-web-devicons", opts = {} } },
  lazy = false,
  opts = {
    default_file_explorer = false, -- Không ghi đè netrw (ta sẽ gọi bằng <leader>-)
    columns = {
      "icon",                      -- Hiện icon file (nếu có nvim-web-devicons)
      -- "permissions", "size", "mtime"
    },
    delete_to_trash = true,               -- Di chuyển vào trash thay vì xoá hẳn
    skip_confirm_for_simple_edits = true, -- Đỡ phiền khi rename, move file nhỏ
    view_options = {
      show_hidden = true,                 -- Hiện file .env, .gitignore, v.v.
      is_always_hidden = function(name, _)
        return name == "node_modules"
            or name == ".next"
            or name == "dist"
            or name == ".git"
            or name == ".cache"
            or name == ".vscode"
            or name == ".idea"
            or name == "obj"
            or name == "bin"
            or name == "build"
      end,
    },
    float = {
      padding = 2,
      border = "rounded",
      max_width = 0.5,
      max_height = 0.8,
      -- preview_split: Split direction: "auto", "left", "right", "above", "below".
      preview_split = "below",
    },
    -- Configuration for the file preview window
    preview_win = {
      -- Whether the preview window is automatically updated when the cursor is moved
      update_on_cursor_moved = true,
      -- How to open the preview window "load"|"scratch"|"fast_scratch"
      preview_method = "fast_scratch",
      -- A function that returns true to disable preview on a file e.g. to avoid lag
      disable_preview = function(filename)
        return false
      end,
      -- Window-local options to use for preview window buffers
      win_options = {},
    },
    confirmation = {
      -- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
      -- min_width and max_width can be a single value or a list of mixed integer/float types.
      -- max_width = {100, 0.8} means "the lesser of 100 columns or 80% of total"
      max_width = 0.9,
      -- min_width = {40, 0.4} means "the greater of 40 columns or 40% of total"
      min_width = { 40, 0.4 },
      -- optionally define an integer/float for the exact width of the preview window
      width = nil,
      -- Height dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
      -- min_height and max_height can be a single value or a list of mixed integer/float types.
      -- max_height = {80, 0.9} means "the lesser of 80 columns or 90% of total"
      max_height = 0.9,
      -- min_height = {5, 0.1} means "the greater of 5 columns or 10% of total"
      min_height = { 5, 0.1 },
      -- optionally define an integer/float for the exact height of the preview window
      height = nil,
      border = "rounded",
      win_options = {
        winblend = 0,
      },
    },
    -- Configuration for the floating progress window
    progress = {
      max_width = 0.5,
      min_width = { 40, 0.4 },
      width = nil,
      max_height = { 10, 0.9 },
      min_height = { 5, 0.1 },
      height = nil,
      border = "rounded",
      minimized_border = "rounded",
    },
    -- Configuration for the floating SSH window
    ssh = {
      border = 'rounded',
    },
    -- Configuration for the floating keymaps help window
    keymaps_help = {
      border = 'rounded',
    },
    keymaps = {
      ["<Esc>"] = "actions.close",
      ["q"] = "actions.close",
      -- ["l"] = "actions.select",
      ["<CR>"] = "actions.select",
      -- ["h"] = "actions.parent",
      ["-"] = "actions.parent",
      ["\\"] = "actions.select_vsplit",
      ["="] = "actions.select_split",
      ["<C-r>"] = "actions.refresh",
      ["~"] = "actions.open_cwd",
      ["<C-p>"] = "actions.preview",
    },
  },
  keys = {
    -- Mở oil ở thư mục chứa file hiện tại
    {
      "-",
      function()
        -- require("oil").open_float()
        require("oil").open()
      end,
      desc = "Open parent directory (float)",
    },

    -- Mở oil root project
    {
      "_",
      function()
        -- require("oil").open_float(vim.fn.getcwd())
        require("oil").open(vim.fn.getcwd())
      end,
      desc = "Oil (Root Dir)",
    },
  },
}
