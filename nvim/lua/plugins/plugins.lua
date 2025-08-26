return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = { "K", false }
      keys[#keys + 1] = {
        "<C-i>",
        function()
          vim.lsp.buf.hover()
        end,
        desc = "Hover",
      }
      opts.servers["gopls"] = {
        settings = {
          hints = {
            parameterNames = false,
            assignVariableTypes = false,
          },
        },
      }
      opts.inlay_hints = {
        enabled = false,
      }
      return opts
    end,
  },
  {
    "folke/snacks.nvim",
    opts = {
      image = {
        enabled = true,
      },
    },
  },
  {
    "Saghen/blink.cmp",
    opts = {
      keymap = {
        ["<C-l>"] = { "accept", "fallback" },
      },
      completion = {
        ghost_text = { enabled = false },
      },
    },
  },
}
