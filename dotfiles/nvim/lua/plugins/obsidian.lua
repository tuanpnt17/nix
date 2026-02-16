return {
  {
    "obsidian-nvim/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    -- ft = "markdown",
    event = {
      "BufReadPre " .. vim.fn.expand("~") .. "/vaults/*.md",
      "BufNewFile " .. vim.fn.expand("~") .. "/vaults/*.md",
    },
    opts = {
      workspaces = {
        {
          name = "personal",
          path = "~/vaults/personal",
        },
      },
      notes_subdir = "Inbox",
      new_note_location = "notes_subdir",
      note_id_func = function(title)
        return title or tostring(os.time())
      end,
      daily_notes = {
        folder = "Journal",
        date_format = "%Y-%m-%d",
        alias_format = "%B %-d, %Y",
        default_tags = { "daily" },
      },
      footer = {
        enabled = false,
      },
      ui = {
        enable = false,
        ignore_conceal_warn = false,
        update_debounce = 200,
        max_file_length = 5000,
      },
      statusline = {
        format = "{{backlinks}} backlinks  {{properties}} properties  {{words}} words  {{chars}} chars",
        enabled = true,
      },
    },
    config = function(_, opts)
      require("obsidian").setup(opts)

      -- ✅ Global keymaps (ngoài buffer)
      vim.keymap.set("n", ";n", "<cmd>ObsidianNew<cr>", { desc = "New note (Inbox)" })
      vim.keymap.set("n", ";i", "<cmd>Obsidian paste_img<cr>", { desc = "Paste copied image" })
      vim.keymap.set("n", ";b", "<cmd>ObsidianBacklinks<cr>", { desc = "Open Backlinks" })
      vim.keymap.set("n", ";t", "<cmd>ObsidianToday<cr>", { desc = "Today journal" })
      vim.keymap.set("n", ";y", "<cmd>ObsidianYesterday<cr>", { desc = "Yesterday journal" })
      vim.keymap.set("n", ";m", "<cmd>ObsidianTomorrow<cr>", { desc = "Tomorrow journal" })
      vim.keymap.set("n", ";q", "<cmd>ObsidianQuickSwitch<cr>", { desc = "Quick switch note" })
      vim.keymap.set("n", ";s", "<cmd>ObsidianSearch<cr>", { desc = "Search notes" })
    end,
  },
}
