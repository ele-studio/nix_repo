return {
  -- Shopify CLI Language Server + enhanced LSP setup
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}

      -- Shopify CLI Language Server (includes Theme Check)
      opts.servers.shopify_theme_ls = {
        cmd = { 'shopify', 'theme', 'language-server' },
        filetypes = { 'liquid' },
        root_dir = function(fname)
          local util = require('lspconfig.util')
          return util.root_pattern(
            '.shopifyignore',
            '.theme-check.yml',
            '.theme-check.yaml',
            'shopify.theme.toml'
          )(fname)
        end,
        settings = {},
      }

      -- Enhanced HTML support for Liquid (disable formatting)
      opts.servers.html = {
        filetypes = { "html", "liquid" },
        settings = {
          html = {
            format = {
              enable = false,       -- disable HTML formatting completely
              templating = true,    -- optional: keep indentation for templating
              wrapLineLength = 120, -- ignored when enable = false
            },
          },
        },
      }

      -- Enhanced CSS support for Liquid (disable formatting)
      opts.servers.cssls = {
        filetypes = { "css", "scss", "sass", "liquid" },
        settings = {
          css = {
            lint = {
              unknownAtRules = "ignore",
            },
            format = {
              enable = false,     -- disable CSS formatting in `.liquid` buffers
            },
          },
        },
      }
    end,
  },

  -- Liquid syntax highlighting
  {
    "tpope/vim-liquid",
    ft = { "liquid" },
  },

  -- Emmet for faster HTML/Liquid development
  {
    "mattn/emmet-vim",
    ft = { "html", "liquid", "css", "scss" },
    config = function()
      vim.g.user_emmet_settings = {
        liquid = { extends = "html" },
      }
    end,
  },

  -- Color highlighting for CSS
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({ "*" })
    end,
  },

  -- Disable Formatting for Liquid + add liquid filetype detection
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "html", "liquid" })

      vim.filetype.add({
        extension = { liquid = "liquid" },
      })
    end,
  },
}
