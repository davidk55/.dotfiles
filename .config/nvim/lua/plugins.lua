local u = require("utils")        -- function to load the configuration file

require("plugins.nvim-cmp")       -- load the nvim-cmp configigurations
require("plugins.lsp.lsp-servers")    -- load the lsp server configurations


return require("packer").startup(function()

  -- ************************** PACKER ITSELF **************************
  use "wbthomason/packer.nvim"

  -- ************************** LOOK AND FEEL **************************
  use "ellisonleao/gruvbox.nvim"
  use {
    "nvim-lualine/lualine.nvim",
    config = u.load_setup("lualine")
  }
  use {
    "romgrk/barbar.nvim",
    requires = { "kyazdani42/nvim-web-devicons" }
  }

  -- ************************** GIT **************************
  use {
    "lewis6991/gitsigns.nvim",
    config = u.load_setup("gitsigns")
  }

  -- ************************** TREESITTER **************************
  use {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      config = u.load_setup("nvim-treesitter")
  }
  use "mfussenegger/nvim-jdtls"
  use "nvim-treesitter/playground"

  -- ************************** TELESCOPE **************************
  use {
    "nvim-telescope/telescope.nvim",
    config = u.load_setup("telescope")
  }
  use {
    "nvim-telescope/telescope-fzf-native.nvim",
    run = "make"
  }

  -- ************************** COMMENTS **************************
  use {
    "folke/todo-comments.nvim",
    config = u.load_setup("todo-comments")
  }
  use {
    "numToStr/Comment.nvim",
    config = require("Comment").setup()
  }

  -- ************************** LSP **************************
  use "neovim/nvim-lspconfig"

  -- ************************** SNIPPETS **************************
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-cmdline"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-nvim-lua"
  use "hrsh7th/cmp-calc"
  use {
    "L3MON4D3/LuaSnip",
    config = u.load_setup("luasnip"),
  }
  use "saadparwaiz1/cmp_luasnip"

  -- ************************** MISC **************************
  use {
    "lukas-reineke/indent-blankline.nvim",
    config = u.load_setup("indent_blankline")
  }
  use {
    "windwp/nvim-autopairs",
    config = u.load_setup("nvim-autopairs")
  }
  use {
    "norcalli/nvim-colorizer.lua",
    config = u.load_setup("nvim-colorizer")
  }

  -- ************************** LATEX **************************
  use "lervag/vimtex"

  -- ************************** DEPENDENCIES **************************
  use "nvim-lua/plenary.nvim"
  use "kyazdani42/nvim-web-devicons"

end)
