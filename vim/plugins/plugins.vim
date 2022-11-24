call plug#begin('~/.config/nvim/autoload/plugged')

"
" Colorschemes...
"
"     ▜         ▌
" ▛▘▛▌▐ ▛▌▛▘▛▘▛▘▛▌█▌▛▛▌█▌▛▘
" ▙▖▙▌▐▖▙▌▌ ▄▌▙▖▌▌▙▖▌▌▌▙▖▄▌
"
"
Plug 'joshdick/onedark.vim'
Plug 'ghifarit53/tokyonight-vim'
Plug 'sonph/onehalf', {'rtp': 'vim/'}
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'sainnhe/sonokai'
Plug 'sickill/vim-monokai'
Plug 'bluz71/vim-moonfly-colors'
Plug 'morhetz/gruvbox'
" Plug 'catppuccin/nvim', {'as': 'catppuccin'}
Plug 'andreasvc/vim-256noir'
Plug 'luisiacc/gruvbox-baby', {'branch': 'main'}
"
"     ▗         ▗   ▐▘▐▘
" █▌▚▘▜▘▛▘▀▌  ▛▘▜▘▌▌▜▘▜▘
" ▙▖▞▖▐▖▌ █▌  ▄▌▐▖▙▌▐ ▐
"
"
Plug 'voldikss/vim-floaterm'
Plug 'MunifTanjim/nui.nvim'
Plug 'VonHeikemen/searchbox.nvim'
Plug 'gaoDean/autolist.nvim'
Plug 'powerline/powerline'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdtree'
Plug 'farmergreg/vim-lastplace'
Plug 'mhinz/vim-startify'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tonadev/vim-airline-256noir'
Plug 'vimwiki/vimwiki'
Plug 'preservim/vim-pencil'
Plug 'dpelle/vim-LanguageTool'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/goyo.vim'
Plug 'tpope/vim-fireplace'
Plug 'junegunn/vim-easy-align'
Plug 'tyru/open-browser.vim'
Plug 'http://github.com/tpope/vim-surround' " Surrounding ysw)


Plug 'preservim/nerdtree'

" Inner nerdtree plugins here
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'scrooloose/nerdtree-project-plugin'
Plug 'PhilRunninger/nerdtree-buffer-ops'
Plug 'PhilRunninger/nerdtree-visual-selection'
Plug 'kyazdani42/nvim-web-devicons' " Recommended (for coloured icons)
" Plug 'ryanoasis/vim-devicons' Icons without colours
Plug 'akinsho/bufferline.nvim', { 'tag': 'v2.*'  }

Plug 'ap/vim-buftabline'
Plug 'mkitt/tabline.vim'

" Telescope plugins
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0'  }
Plug 'junegunn/fzf', { 'do': { -> fzf#install()  }  }

"      ▌▘        ▗   ▐▘▐▘
" ▛▘▛▌▛▌▌▛▌▛▌  ▛▘▜▘▌▌▜▘▜▘
" ▙▖▙▌▙▌▌▌▌▙▌  ▄▌▐▖▙▌▐ ▐
"          ▄▌

" Plug 'phpactor/phpactor' ,  {'do': 'composer install', 'for': 'php'}
" Plug 'ncm2/ncm2'
" Plug 'roxma/nvim-yarp'
" Plug 'phpactor/ncm2-phpactor'

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'ap/vim-css-color'
Plug 'dense-analysis/ale'
Plug 'plasticboy/vim-markdown'
Plug 'https://github.com/preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'kyazdani42/nvim-tree.lua'
Plug 'https://github.com/ap/vim-css-color'
Plug 'https://github.com/tpope/vim-commentary' " For Commenting gcc & gc

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

call plug#end()
