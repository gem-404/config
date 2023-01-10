----------------------------------------------------------
-- Plugin manager configuration file
-----------------------------------------------------------

-- Plugin manager: packer.nvim
-- url: https://github.com/wbthomason/packer.nvim

-- For information about installed plugins see the README
--- neovim-lua/README.md
--- https://github.com/brainfucksec/neovim-lua#readme


local cmd = vim.cmd
cmd [[packadd packer.nvim]]

local packer = require 'packer'

-- Add packages
return packer.startup(function()
  use 'wbthomason/packer.nvim' -- packer can manage itself
  -- use 'gaoDean/autolist.nvim'

  use { "zbirenbaum/copilot.lua" }

  -- use {
  --     "zbirenbaum/copilot.lua",
  --     event = "VimEnter",
  --     config = function()
  --       vim.defer_fn(function()
  --         require("copilot").setup()
  --       end, 100)
  --     end,
  -- }

  -- 2022-12-28 15:00:00.000000000 +0100
  use { 'CRAG666/code_runner.nvim', requires = 'nvim-lua/plenary.nvim' }

  -- install theprimeagen harpoon
  use { 
      'ThePrimeagen/harpoon'
      -- require("telescope").load_extension('harpoon'),
  }

  use({
    "glepnir/lspsaga.nvim",
    branch = "main",
    config = function()
        local saga = require("lspsaga")

        saga.init_lsp_saga({
            -- your configuration
            -- local keymap = vim.keymap.set

        -- Lsp finder find the symbol definition implement reference
        -- if there is no implement it will hide
        -- when you use action in finder like open vsplit then you can
        -- use <C-t> to jump back
            -- keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })

            -- Code action
            -- keymap({"n","v"}, "<leader>ca", "<cmd>Lspsaga code_action<CR>", { silent = true })

            -- Rename
            -- keymap("n", "gr", "<cmd>Lspsaga rename<CR>", { silent = true })

            -- Peek Definition
            -- you can edit the definition file in this flaotwindow
            -- also support open/vsplit/etc operation check definition_action_keys
            -- support tagstack C-t jump back
            -- keymap("n", "gd", "<cmd>Lspsaga peek_definition<CR>", { silent = true })

            -- Show line diagnostics
            -- keymap("n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })

            -- Show cursor diagnostics
            -- keymap("n", "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { silent = true })

            -- Diagnostic jump can use `<c-o>` to jump back
            -- keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
            -- keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })

            -- Only jump to error
            -- keymap("n", "[E", function()
              -- require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
            -- end, { silent = true })
            -- keymap("n", "]E", function()
              -- require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
            -- end, { silent = true })

            -- Outline
            -- keymap("n","<leader>o", "<cmd>LSoutlineToggle<CR>",{ silent = true })

            -- Hover Doc
            -- keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })

            -- Float terminal
            -- keymap("n", "<A-d>", "<cmd>Lspsaga open_floaterm<CR>", { silent = true })
            -- if you want to pass some cli command into a terminal you can do it like this
            -- open lazygit in lspsaga float terminal
            -- keymap("n", "<A-d>", "<cmd>Lspsaga open_floaterm lazygit<CR>", { silent = true })
            -- close floaterm
            -- keymap("t", "<A-d>", [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], { silent = true })
        })
    end,
  })

  use {
      'VonHeikemen/searchbox.nvim',
      requires = {
        {'MunifTanjim/nui.nvim'}
      }
    }

  -- Added on -> Wednesday, 30 November 2022
  -- duck.nvim

    use {
        'tamton-aquib/duck.nvim',
        config = function()
            vim.keymap.set('n', '<leader>dd', function() require("duck").hatch() end, {})
            vim.keymap.set('n', '<leader>dk', function() require("duck").cook() end, {})
        end
    }

  -- End of duck.nvim
  
  -- some added plugins -> 08/11/2022 -> 11:31 pm
  --
  -- 
  use 'EdenEast/nightfox.nvim'
  use 'Shatur/neovim-ayu'
  use {'kartikp10/noctis.nvim', requires = { 'rktjmp/lush.nvim' }}

  -- End of added plugins...
  -- plugins added on 11/11/2022 -> 10:44pm
  use 'Sirver/ultisnips'
  use 'honza/vim-snippets'

  -- some added plugins -> 08/11/2022 -> 11:31 pm
  use 'eandrju/cellular-automaton.nvim'
  

  use 'sbdchd/neoformat'
  -- use 'Weissle/persistent-breakpoints.nvim'
  -- use 'mfussenegger/nvim-dap'

  use 'catppuccin/nvim'
  use 'ghifarit53/tokyonight-vim'
  use 'jiangmiao/auto-pairs'

  use "hrsh7th/nvim-compe"

  use 'morhetz/gruvbox'

  -- Added mason on 2022-11-23.
  --
  use {'williamboman/mason.nvim'}

  ---------------------------------
  
  use 'bluz71/vim-moonfly-colors'

  -- lspsaga.nvim
  -- use 'glepnir/lspsaga.nvim'

  -- treesitter.nvim
  use 'nvim-treesitter/nvim-treesitter'

  -- NVChad terminal plugin
  use {
      "NvChad/nvterm",
      config = function ()
        require("nvterm").setup()
      end,
  }

  -- Added on 19-11-2022
  --

  use 'digitaltoad/vim-pug'

  -- End of what was added on 19-11-2022
  
  -- Added on 20-11-2022

  use 'sam4llis/nvim-tundra'

  -- End of what was added on 20-11-2022
  

  -- ------------ Added 25/10/2022 ------------
  -- use 'hrsh7th/vim-vsnip-integ'
  -- ------------------------------------------
  -- pywal -like module -> lushwal
	--   use({
	-- "oncomouse/lushwal",
	-- requires = { { "rktjmp/lush.nvim", opt = true }, { "rktjmp/shipwright.nvim", opt = true } },
	--     })
    
  -- Lua
  use {
      "folke/which-key.nvim",
      config = function()
        require("which-key").setup {
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
        }
      end
    }

  -- fatih/vim-go
  use 'fatih/vim-go'

  -- auto-completion
  use 'nvim-lua/completion-nvim'

  -- nvim ranger
  use 'kevinhwang91/rnvimr'

  -- Pocco81 for zenmode
  use 'Pocco81/TrueZen.nvim'
    
  -- nvim neotest
  use {
  "nvim-neotest/neotest",
  requires = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "antoinemadec/FixCursorHold.nvim"
      }
    }

  -- File explorer
  use 'kyazdani42/nvim-tree.lua'

  -- Indent line
  use 'lukas-reineke/indent-blankline.nvim'


  -- Vim fugitive
  use 'tpope/vim-fugitive'

  -- Autopair
  use {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup{}
    end
  }

  -- Icons
  use 'kyazdani42/nvim-web-devicons'



  -- Color schemes
  use 'navarasu/onedark.nvim'

  use 'tanvirtin/monokai.nvim'

  use { 'rose-pine/neovim', as = 'rose-pine' }

  -- LSP
  use {'neovim/nvim-lspconfig', requires = 'mfussenegger/nvim-jdtls'}

  use('jose-elias-alvarez/null-ls.nvim')
  use('MunifTanjim/prettier.nvim')

  use 'L3MON4D3/LuaSnip'

  -- Autocomplete
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'L3MON4D3/LuaSnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-cmdline',
      'saadparwaiz1/cmp_luasnip',
    },
  }

  use 'molleweide/luasnip-snippets.nvim'

  use {
      'hrsh7th/cmp-vsnip', 
      after = 'nvim-cmp',
      requires = {
          'hrsh7th/vim-vsnip',
          {
              'rafamadriz/friendly-snippets',
              after = 'cmp-vsnip'
          }
      }
  }

  -- Statusline
  use {
    'famiu/feline.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
  }

  use {
  'nvim-lualine/lualine.nvim',
  requires = { 'kyazdani42/nvim-web-devicons', opt = true }
}

  -- git labels
  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('gitsigns').setup()
    end
  }

  -- use { 
  --   'glepnir/galaxyline.nvim',
  --   branch = 'main',
  --   requires = { 'kyazdani42/nvim-web-devicons', opt = true },
  --   config = function()
  -- 	    require("my_statusline")
  --   end,
  -- }


  -- Dashboard (start screen) -- mhinz/startify

  use { 'mhinz/vim-startify' }

  use { 'm4xshen/autoclose.nvim' }

  -- file explorer
  -- use {
  --   'kyazdani42/nvim-tree.lua',
  --   cmd = {
  --     'NvimTreeClipboard',
  --     'NvimTreeClose',
  --     'NvimTreeFindFile',
  --     'NvimTreeOpen',
  --     'NvimTreeRefresh',
  --     'NvimTreeToggle',
  --   },
  --   event = 'VimEnter',
  -- }


  --   use {
  --   'neovim/nvim-lspconfig',
  --   requires = {
  --     { 'b0o/SchemaStore.nvim' },
  --     { 'williamboman/nvim-lsp-installer' },
  --     { 'jose-elias-alvarez/nvim-lsp-ts-utils' },
  --     {
  --       'jose-elias-alvarez/null-ls.nvim',
  --       after = 'nvim-lspconfig',
  --     },
  --     {
  --       'ray-x/lsp_signature.nvim',
  --       after = 'nvim-lspconfig',
  --     },
  --   },
  --   event = 'BufWinEnter',
  -- }

  -- williamboman/nvim-lsp-installer
  use 'williamboman/nvim-lsp-installer'

    -- floating terminal
  use {
    'voldikss/vim-floaterm',
  }

  -- file navigation
  use {
    'nvim-telescope/telescope.nvim',
    requires = { { 'nvim-lua/plenary.nvim'}, { "kdheepak/lazygit.nvim" } },
    config = function()
        require("telescope").load_extension("lazygit")
    end,
  }

  use {'akinsho/bufferline.nvim', tag = "*", requires = 'kyazdani42/nvim-web-devicons'}

  use {'JohnnyMorganz/Stylua'}

  use {'artanikin/vim-synthwave84'}

  use {'lunarvim/synthwave84.nvim'};

  use { 'terrortylor/nvim-comment' }

  use { 'Vimjas/vim-python-pep8-indent' }


end)
