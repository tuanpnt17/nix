---@diagnostic disable: unused-function
return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      local clients_lsp = function()
        local clients = vim.lsp.get_clients()
        if next(clients) == nil then
          return ""
        end

        local c = {}
        for _, client in pairs(clients) do
          table.insert(c, client.name)
        end
        return " " .. table.concat(c, "|")
      end

      opts.options = {
        theme = "auto",
        globalstatus = true,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      }

      local LazyVim = require("lazyvim.util")
      local icons = LazyVim.config.icons
      vim.o.laststatus = vim.g.lualine_laststatus

      -- Left sections (lualine_a, lualine_b, lualine_c)
      opts.sections.lualine_a = {
        { "mode" },
      }
      opts.sections.lualine_b = {
        { "branch", icon = "" },
      }
      opts.sections.lualine_c = {
        LazyVim.lualine.root_dir(),
        {
          "diagnostics",
          symbols = {
            error = icons.diagnostics.Error,
            warn = icons.diagnostics.Warn,
            info = icons.diagnostics.Info,
            hint = icons.diagnostics.Hint,
          },
        },
        { "filetype",                   icon_only = true, separator = "", padding = { left = 1, right = 0 } },
        { LazyVim.lualine.pretty_path() },
      }

      -- Right sections (lualine_x, lualine_y, lualine_z)
      opts.sections.lualine_x = {
        -- clients_lsp,
        {
          "diff",
          symbols = {
            added = icons.git.added,
            modified = icons.git.modified,
            removed = icons.git.removed,
          },
          source = function()
            local gitsigns = vim.b.gitsigns_status_dict
            if gitsigns then
              return {
                added = gitsigns.added,
                modified = gitsigns.changed,
                removed = gitsigns.removed,
              }
            end
          end,
          padding = { left = 1, right = 1 },
        },
      }

      opts.sections.lualine_y = {
        { "progress", separator = " ", icon = "", padding = { left = 1, right = 0 } },
        { "location", padding = { left = 0, right = 1 } },
      }

      opts.sections.lualine_z = {
        function()
          return " " .. os.date("%R")
        end,
      }
    end,
  },
}
