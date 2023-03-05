local M = {}

function M.setup()

  
  vim.opt.list = true
  vim.opt.listchars:append "eol:↴"
  show_current_context = true
  show_current_context_start = true

  vim.opt.foldlevel=20
  vim.opt.foldmethod = "expr"
  vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

  -- Indicate first time installation
  local packer_bootstrap = false

  -- packer.nvim configuration
	local conf = {
	profile = {
		enable = true,
		threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
	},  display = {
		open_fn = function()
			return require("packer.util").float { border = "rounded" }
		end,
	},
}


  -- Check if packer.nvim is installed
  -- Run PackerCompile if there are changes in this file
  local function packer_init()
    local fn = vim.fn
    local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
      packer_bootstrap = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
      }
      vim.cmd [[packadd packer.nvim]]
    end
    vim.cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"
  end

  -- Plugins
  local function plugins(use)
    use { "wbthomason/packer.nvim" }

		--lsp config
		use {
  "neovim/nvim-lspconfig",
  opt = true,
  event = "BufReadPre",
  wants = { "nvim-lsp-installer" },
  config = function()
    require("config.lsp").setup()
  end,
  requires = {
    "williamboman/nvim-lsp-installer"
  }
}

    -- Colorscheme
    use {
      "sainnhe/everforest",
      config = function()
        vim.cmd "colorscheme everforest"
      end,
    }

    -- Startup screen
    use {
      "goolord/alpha-nvim",
      config = function()
        require("config.alpha").setup()
      end,
    }

		use {
      "Shatur/neovim-ayu",
			config = function()
				require("ayu").setup({})
			end,
		}
use {
  "folke/which-key.nvim",
  config = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
    require("which-key").setup {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  end
}

		-- IndentLine
use {
  "lukas-reineke/indent-blankline.nvim",
  config = function()
    require("indent_blankline").setup(
		{
			show_end_of_line = true,
		  show_char_blankline = " ",
	    show_current_context = true,
	    show_current_context_start = true
		}
		)
  end,
}

    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }

		-- Better icons
    use {
      "kyazdani42/nvim-web-devicons",
      module = "nvim-web-devicons",
      config = function()
        require("nvim-web-devicons").setup { default = true }
      end,
    }

		use {
		  "SmiteshP/nvim-navic",
			 requires = "neovim/nvim-lspconfig",
			 config = function()
				 require("nvim-navic").setup()
			 end
		}
		use {
			'nvim-lualine/lualine.nvim',
			event = "VimEnter",
			config = function()
				requires = { 'kyazdani42/nvim-web-devicons', opt = true }
				require("config.lualine").setup()
			end
		}

				--require("lualine").setup({options = {theme = 'ayu_dark'}})
    -- Git
    use {
      "TimUntersberger/neogit",
			cmd = "Neogit",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("config.neogit").setup()
      end,
    }


    if packer_bootstrap then
      print "Restart Neovim required after installation!"
      require("packer").sync()
    end
  end


  packer_init()

  local packer = require "packer"
  packer.init(conf)
  packer.startup(plugins)
end

return M
