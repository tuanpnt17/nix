---@diagnostic disable: missing-fields
return {
  {
    "mfussenegger/nvim-dap",
    optional = true,
    keys = {
      { "<F5>",       function() require("dap").continue() end,                        desc = "Run/Continue" },
      { "<F9>",       function() require("dap").toggle_breakpoint() end,               desc = "Toggle Breakpoint" },
      { "<F10>",      function() require("dap").step_over() end,                       desc = "Step Over" },
      { "<F11>",      function() require("dap").step_into() end,                       desc = "Step Into" },
      { "<F12>",      function() require("dap").step_out() end,                        desc = "Step Out" },
      { "<F8>",       function() require('neotest').run.run({ strategy = 'dap' }) end, desc = "Test" },
      { "<leader>dr", function() require("dap").repl.toggle() end,                     desc = "Toggle REPL" },
      { "<leader>dt", function() require("dap").terminate() end,                       desc = "Terminate" },
      { "<leader>dl", function() require("dap").run_last() end,                        desc = "Run Last" },
    },
    opts = function()
      local dap = require("dap")

      local netcoredbg_adapter = {
        type = "executable",
        command = vim.fn.exepath("netcoredbg"),
        args = { "--interpreter=vscode" },
        options = {
          detached = false,
        },
      }
      if not dap.adapters["netcoredbg"] then
        require("dap").adapters["netcoredbg"] = netcoredbg_adapter
        require("dap").adapters["coreclr"] = netcoredbg_adapter
      end
      for _, lang in ipairs({ "cs", "fsharp", "vb", "razor" }) do
        if not dap.configurations[lang] then
          dap.configurations[lang] = {
            {
              type = "netcoredbg",
              name = "Launch file",
              request = "launch",
              ---@diagnostic disable-next-line: redundant-parameter
              program = function()
                return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/", "file")
              end,

              cwd = "${workspaceFolder}",
            },
          }
        end
      end
    end,
  },
  {
    'ramboe/ramboe-dotnet-utils',
    dependencies = { 'mfussenegger/nvim-dap' }
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "nvim-neotest/nvim-nio" },
    -- stylua: ignore
    keys = {
      { "<leader>du", function() require("dapui").toggle({}) end, desc = "Dap UI" },
      { "<leader>de", function() require("dapui").eval() end,     desc = "Eval",  mode = { "n", "x" } },
    },
    opts = {},
    config = function(_, opts)
      local dap = require("dap")
      local dapui = require("dapui")
      -- dapui.setup(opts)
      dapui.setup({
        expand_lines = true,
        controls = { enabled = false }, -- no extra play/step buttons
        floating = { border = "rounded" },
        -- Set dapui window
        render = {
          max_type_length = 60,
          max_value_lines = 200,
        },
        -- Only one layout: just the "scopes" (variables) list at the bottom
        layouts = {
          {
            elements = {
              "repl",
              "breakpoints",
            },
            size = 40, -- 40 columns
            position = "right",
          },
          {
            elements = {
              { id = "scopes", size = 1.0 }, -- 100% of this panel is scopes
            },
            size = 15,                       -- height in lines (adjust to taste)
            position = "bottom",             -- "left", "right", "top", "bottom"
          },
        }
      })

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open({})
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close({})
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close({})
      end
    end,
  }

}
