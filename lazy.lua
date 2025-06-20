return {
  dir = "~/Repos/neovim/invert.nvim",
  opts = {},
  keys = {
    {
      "<leader>i",
      function()
        require("invert").invert()
      end,
      mode = "n",
      desc = "invert.nvim: Invert token under cursor",
      noremap = true,
      silent = true,
    },
  },
}
