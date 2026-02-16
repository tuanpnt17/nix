return {
  "rachartier/tiny-inline-diagnostic.nvim",
  event = "VeryLazy", -- Or `LspAttach`
  priority = 1000,    -- needs to be loaded in first
  config = function()
    require("tiny-inline-diagnostic").setup({
      preset = "modern",
      signs = {
        left = "",
        right = "",
        diag = "●",
        arrow = "    ",
        up_arrow = "    ",
        vertical = " │",
        vertical_end = " └",
      },
      blend = {
        factor = 0.22,
      },
      transparent_bg = false,         -- Set the background of the diagnostic to transparent
      transparent_cursorline = false, -- Set the background of the cursorline to transparent (only one the first diagnostic)
      hi = {
        error = "DiagnosticError",    -- Highlight group for error messages
        warn = "DiagnosticWarn",      -- Highlight group for warning messages
        info = "DiagnosticInfo",      -- Highlight group for informational messages
        hint = "DiagnosticHint",      -- Highlight group for hint or suggestion messages
        arrow = "NonText",            -- Highlight group for diagnostic arrows
        background = "CursorLine",
        mixing_color = "None",
      },

      options = {
        show_source = {
          enabled = false,
          if_many = false,
        },
        use_icons_from_diagnostic = false,
        set_arrow_to_diag_color = false,
        add_messages = true,
        throttle = 20,
        softwrap = 30,
        multilines = {
          enabled = false,
          always_show = false,
          trim_whitespaces = false,
          tabstop = 4,
        },
        show_all_diags_on_cursorline = false,
        enable_on_insert = false,
        enable_on_select = false,
        overflow = {
          mode = "wrap",
          padding = 0,
        },
        break_line = {
          enabled = false,
          after = 30,
        },
        format = nil,
        virt_texts = {
          priority = 2048,
        },
        severity = {
          vim.diagnostic.severity.ERROR,
          vim.diagnostic.severity.WARN,
          vim.diagnostic.severity.INFO,
          vim.diagnostic.severity.HINT,
        },
        overwrite_events = nil,
      },
      disabled_ft = {},                             -- List of filetypes to disable the plugin
    })
    vim.diagnostic.config({ virtual_text = false }) -- Only if needed in your configuration, if you already have native LSP diagnostics

    local keymap = vim.keymap
    -- Diagnostics
    keymap.set("n", "<Leader>xc", function()
      local diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line(".") - 1 })
      if #diagnostics > 0 then
        local message = diagnostics[1].message
        vim.fn.setreg("+", message)
        print("Copied diagnostic: " .. message)
      else
        print("No diagnostic at cursor")
      end
    end, { noremap = true, silent = true, desc = "Copy diagnostic message to clipboard" }) -- Copy diagnostic message to clipboard

    keymap.set(
      "n",
      "<Leader>xf",
      vim.diagnostic.open_float,
      { noremap = true, silent = true, desc = "Show diagnostics in a floating window" }
    )

    keymap.set("n", "<Leader>xn", function()
      vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
    end, { noremap = true, silent = true, desc = "Go to next error" })

    keymap.set("n", "<Leader>xp", function()
      vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
    end, { noremap = true, silent = true, desc = "Go to prev error" })
  end,
}
