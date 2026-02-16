return
{
  "stevearc/conform.nvim",
  -- event = 'BufWritePre', -- uncomment for format on save
  opts = {
    async = true,
    formatters_by_ft = {
      cs = { "csharpier_ramboe" },
      csproj = { "csharpier_ramboe" },
      ["markdown"] = { "prettier", "markdownlint-cli2", "markdown-toc" },
      ["markdown.mdx"] = { "prettier", "markdownlint-cli2", "markdown-toc" },
    },
    formatters = {
      csharpier_ramboe = {
        command = "csharpier",
        args = {
          "format",
          "--write-stdout",
        },
        to_stdin = true,
      },
    },
    format_on_save = {
      -- These options will be passed to conform.format()
      timeout_ms = 500,
      lsp_fallback = true,
    },
  },
}
