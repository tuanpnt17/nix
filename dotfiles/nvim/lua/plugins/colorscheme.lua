return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavor = "mocha",              -- latte, frappe, macchiato, mocha
      transparent_background = true, -- disables setting the background color.
      float = {
        transparent = true,          -- enable transparent floating windows
        solid = false,               -- use solid styling for floating windows, see |winborder|
      },
      integrations = {
        roslyn = true,
      }
    }
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
