return {
  {
    "folke/noice.nvim",
    opts = {
      presets = {
        lsp_doc_border = true,
      },
    },
  },
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      window = {
        backdrop = 1,
        width = 0.85,
        height = 1,
        options = {
          number = true,
          relativenumber = true,
          signcolumn = "yes",
          foldcolumn = "1",
        },
      },
      plugins = {
        gitsigns = true,
        tmux = { enabled = false }, -- disables the tmux statusline
        kitty = {
          enabled = false,
          font = "+4", -- font size increment
        },
        wezterm = { enabled = false, font = "+2" },
        twilight = { enabled = false },
      },
    },
    keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
  },
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = [[
        ████████╗██╗   ██╗ █████╗ ███╗   ██╗██████╗ ███╗   ██╗████████╗
        ╚══██╔══╝██║   ██║██╔══██╗████╗  ██║██╔══██╗████╗  ██║╚══██╔══╝
        ██║   ██║   ██║███████║██╔██╗ ██║██████╔╝██╔██╗ ██║   ██║
        ██║   ██║   ██║██╔══██║██║╚██╗██║██╔═══╝ ██║╚██╗██║   ██║
        ██║   ╚██████╔╝██║  ██║██║ ╚████║██║     ██║ ╚████║   ██║
        ╚═╝    ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝     ╚═╝  ╚═══╝   ╚═╝
         ]],
        },
      },
      terminal = {
        win = {
          position = "float",
          border = "rounded",
        },
      },
      keys = {
        { "<leader>fe", false },
        { "<leader>fE", false },
        { "<leader>E",  false },
        { "<leader>e",  false },
      },
      picker = {
        sources = {
          explorer = {
            layout = {
              auto_hide = { "input" },
            },
            win = {
              list = {
                keys = {
                  ["A"] = "explorer_add_dotnet",
                },
              },
            },
            actions = {
              explorer_add_dotnet = function(picker)
                local dir = picker:dir()
                local easydotnet = require("easy-dotnet")

                easydotnet.create_new_item(dir, function(item_path)
                  local tree = require("snacks.explorer.tree")
                  local actions = require("snacks.explorer.actions")
                  tree:open(dir)
                  tree:refresh(dir)
                  actions.update(picker, { target = item_path })
                  picker:focus()
                end)
              end,
            },
          },
        },
      },
      scroll = {
        enabled = false, -- Disable scrolling animations
      },
      explorer = {
        show_hidden = true,
        exclude = {
          "**/.git/*",
          "**/bin/*",
          "**/obj/*",
        }
      },
    },
  },
}
