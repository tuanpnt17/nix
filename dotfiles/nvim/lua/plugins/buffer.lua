return {
  -- buffer line
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {
      options = {
        mode = "tabs", -- "buffers" | "tabs"
        separator_style = "thick",
        show_buffer_close_icons = true,
        show_close_icon = true,
      },
    },
  },

  -- filename
  {
    "b0o/incline.nvim",
    dependencies = { "catppuccin/nvim" },
    event = "BufReadPre",
    priority = 1200,
    config = function()
      -- Lấy màu từ catppuccin mocha
      local cp = require("catppuccin.palettes").get_palette("mocha")

      require("incline").setup({
        highlight = {
          groups = {
            InclineNormal = { guibg = cp.blue, guifg = cp.mantle },
            InclineNormalNC = { guibg = cp.surface1, guifg = cp.subtext0 },
          },
        },
        window = { margin = { vertical = 0, horizontal = 0 } },
        hide = {
          cursorline = true,
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          if vim.bo[props.buf].modified then
            filename = "[+] " .. filename
          end

          local icon = require("nvim-web-devicons").get_icon_color(filename)
          return { { icon }, { " " }, { filename } }
        end,
      })
    end,
  },
}
