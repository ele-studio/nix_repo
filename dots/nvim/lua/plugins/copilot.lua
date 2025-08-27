return {
  {
    "github/copilot.vim",
    event = "InsertEnter", -- Load when entering insert mode
    config = function()
      -- Basic Copilot settings
      vim.g.copilot_no_tab_map = true -- Disable default Tab mapping
      vim.g.copilot_assume_mapped = true

      -- Custom keymaps for Copilot
      vim.keymap.set("i", "<M-Space>", 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false,
        desc = "Accept Copilot suggestion"
      })

      vim.keymap.set("i", "<M-L>", "<Plug>(copilot-accept-word)", {
        desc = "Accept Copilot word"
      })

      vim.keymap.set("i", "<M-H>", "<Plug>(copilot-dismiss)", {
        desc = "Dismiss Copilot suggestion"
      })

      vim.keymap.set("i", "<M-N>", "<Plug>(copilot-next)", {
        desc = "Next Copilot suggestion"
      })

      vim.keymap.set("i", "<M-P>", "<Plug>(copilot-previous)", {
        desc = "Previous Copilot suggestion"
      })

      vim.g.copilot_filetypes = {
        ["*"] = false,
        ["javascript"] = true,
        ["typescript"] = true,
        ["lua"] = true,
        ["rust"] = true,
        ["python"] = true,
      }
    end,
  },
}
