local u = require("utils") -- function to load the configuration file

require("plugins.nvim-cmp") -- load the nvim-cmp configigurations
require("plugins.lsp") -- load the lsp server configurations

return require("packer").startup(function()
  -- ************************** PACKER ITSELF **************************
  use("wbthomason/packer.nvim")

  -- ************************** LOOK AND FEEL **************************
  use("ellisonleao/gruvbox.nvim")
  use({
    "nvim-lualine/lualine.nvim",
    config = u.load_setup("lualine"),
  })
  use("SmiteshP/nvim-navic")
  use({
    "romgrk/barbar.nvim",
    requires = { "kyazdani42/nvim-web-devicons" },
  })
  use("rcarriga/nvim-notify")
  vim.notify = require("notify")

  -- ************************** MOVEMENT **************************
  use({
    "ggandor/lightspeed.nvim",
    config = u.load_setup("lightspeed"),
  })

  -- ************************** GIT **************************
  use({
    "lewis6991/gitsigns.nvim",
    config = u.load_setup("gitsigns"),
  })

  -- ************************** TREESITTER **************************
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = u.load_setup("nvim-treesitter"),
  })
  use("nvim-treesitter/nvim-treesitter-context")
  use("mfussenegger/nvim-jdtls")
  use("nvim-treesitter/playground")

  -- ************************** TELESCOPE **************************
  use({
    "nvim-telescope/telescope.nvim",
    config = u.load_setup("telescope"),
  })
  use({
    "nvim-telescope/telescope-fzf-native.nvim",
    run = "make",
  })

  -- ************************** COMMENTS **************************
  use({
    "folke/todo-comments.nvim",
    config = u.load_setup("todo-comments"),
  })
  use({
    "numToStr/Comment.nvim",
    config = require("Comment").setup(),
  })

  -- ************************** LSP **************************
  use("neovim/nvim-lspconfig")
  use("mfussenegger/nvim-dap")
  use({
    "folke/trouble.nvim",
    config = u.load_setup("trouble"),
  })
  use({
    "glepnir/lspsaga.nvim",
    config = u.load_setup("lspsaga"),
  })
  use({
    "jose-elias-alvarez/null-ls.nvim",
    config = u.load_setup("null-ls"),
  })

  -- ************************** SNIPPETS **************************
  use("hrsh7th/nvim-cmp")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-path")
  use("hrsh7th/cmp-cmdline")
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-nvim-lua")
  use("hrsh7th/cmp-calc")
  use("hrsh7th/cmp-nvim-lsp-signature-help")
  use({
    "L3MON4D3/LuaSnip",
    config = u.load_setup("luasnip"),
  })
  use("saadparwaiz1/cmp_luasnip")
  use("rafamadriz/friendly-snippets")

  -- ************************** MISC **************************
  use({
    "lukas-reineke/indent-blankline.nvim",
    config = u.load_setup("indent_blankline"),
  })
  use({
    "windwp/nvim-autopairs",
    config = u.load_setup("nvim-autopairs"),
  })
  use({
    "NvChad/nvim-colorizer.lua",
    config = u.load_setup("nvim-colorizer"),
  })
  use({
    "https://github.com/uga-rosa/ccc.nvim",
    branch = "0.7.2",
  })
  use({
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup({})
    end,
  })
  use({
    "ahmedkhalf/project.nvim",
    config = u.load_setup("project"),
  })

  -- markdown viewer
  use({
    "ellisonleao/glow.nvim",
  })

  -- nvim in the browser
  use({
    "glacambre/firenvim",
    run = function()
      vim.fn["firenvim#install"](0)
    end,
  })

  use("lervag/vimtex")

  use({
    "kyazdani42/nvim-tree.lua",
    config = u.load_setup("nvim-tree"),
  })

  use({
    "akinsho/toggleterm.nvim",
    config = u.load_setup("toggleterm"),
  })

  use({
    "kevinhwang91/nvim-ufo",
    requires = "kevinhwang91/promise-async",
    config = u.load_setup("nvim-ufo"),
  })
  use("elkowar/yuck.vim")
  use("jbyuki/venn.nvim")

  -- ************************** DEPENDENCIES **************************
  use("nvim-lua/plenary.nvim")
  use("kyazdani42/nvim-web-devicons")
end)
