
-----------------------------------------------------------
-- Define keymaps of Neovim and installed plugins.
-----------------------------------------------------------

local function map(mode, lhs, rhs, opts)
local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end


-- Change leader to a comma
vim.g.mapleader = ' '

-- telescope planets
map('n', '<leader>pp', ':lua require"telescope.builtin".planets{}<cr>')
map('n', '<leader>ff', ':FZF<cr>')

map('n', '<leader>cx', ':!chmod +x %<cr><cr>')

map('n', '<leader>y', "\"+y")
map('v', '<leader>y', "\"+y")
map('n', '<leader>Y', "\"+Y")

-- From the PRIMEAGEN
map('v', '<A-d>', ':m \'>+1<cr>gv=gv')
map('v', '<A-u>', ':m \'<-2<cr>gv=gv')

-- Could not use A-k and A-j to move visually selected text up and down
-- due to the fact that the same hotkeys are used by .tmux.conf
-- used A-u and A-d for alt-up and alt-down... -> You are welcome


map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')

map('n', '<leader>h', ':nohlsearch<cr>')

-- map('x', '<leader>p', '"_dP')
map('x', '<leader>p', '\"_dP')

-- End of PRIMEAGEN config

-- Added on -> Wednesday, 30 November 2022
-- duck.nvim
map('n', '<leader>dc', ':lua require("duck").hatch("🦆")<cr>')
map('n', '<leader>dk', ':lua require("duck").cook("🦆")<cr>')
-- map('n', '<leader>dd', 'function() require("duck").hatch("🦆", 10) end, {}') -- A pretty fast duck
-- map('n', '<leader>dc', 'function() require("duck").hatch("🐈", 0.75) end, {}') -- Quite a mellow cat

-- You can also specify how fast a duck moves(measured in steps per second)

-- Save breakpoints to file automatically.
-- map("n", "<leader><leader>b", "<cmd>lua require('persistent-breakpoints.api').toggle_breakpoint()<cr>", opts)

-- map("n", "<YourKey2>", "<cmd>lua require('persistent-breakpoints.api').set_conditional_breakpoint()<cr>", opts)

-- map("n", "<leader><leader>c", "<cmd>lua require('persistent-breakpoints.api').clear_all_breakpoints()<cr>", opts)

-- 2022-12-18
map('n', '<leader>ca', '<cmd>Lspsaga code_action<CR>', { silent = true })

------------------- config added on 12:29 PM -----------------

map('n', '<leader>bk', ":lua require'dap'.toggle_breakpoint()<cr>")

------------------- end of config ----------------------------
map('n', '<F12>', ':TZAtaraxis<cr>')

-- Add lukas-reineke/indent-blankline.nvim 11:50 AM 2022-11-22
-- Search for another auto-pairs plugin to use...

--lazygit configurations
map('n', '<leader>gg', ':LazyGit<cr>')

-- nvimranger configurations
map('n', '<leader>ra', ':RnvimrToggle<cr>')

-- quit! mapping
map('n', '<C-q>', ':q!<cr>')

-- Quickfix mappings
map('i', 'jj', '<esc>', { noremap = true, silent = true })

map('n', '<leader>ck', ':cexpr []<cr>')
map('n', '<leader>cc', ':cclose <cr>')
map('n', '<leader>co', ':copen <cr>')
map('n', '<leader>cf', ':cfdo %s/')
map('n', '<leader>cp', ':cprev<cr>zz')
map('n', '<leader>cn', ':cnext<cr>zz')

-- cellular-automaton.nvim ... Added on 29-11-2022
map('n', '<leader>cm', '<cmd>CellularAutomaton make_it_rain<cr>')
map('n', '<leader>cg', '<cmd>CellularAutomaton game_of_life<cr>')


-- Yanking and copying whole files in neovim
map('n', '<f5>', ':%y<cr>')
map('n', '<f6>', 'ggVGp')
map('n', '<f4>', 'ggVG')
map('n', '<f8>', 'ggVGd')
map('n', '<f2>', 'Go<cr>')
map('n', '<f7>', 'dG')

-- Quick Colorscheme changings
map('n', '<leader>tc', ':colorscheme rose-pine<cr>')
map('n', '<leader>tm', ':colorscheme monokai_soda<cr>')

map('n', '<leader>tb', ':colorscheme gruvbox<cr>')

map('n', '<leader>td', ':colorscheme default<cr>')
map('n', '<leader>ts', ':colorscheme synthwave84<cr>')
map('n', '<leader>tz', ':colorscheme zellner<cr>')
map('n', '<leader>ta', ':colorscheme ayu<cr>')
map('n', '<leader>to', ':colorscheme onedark<cr>')
map('n', '<leader>ty', ':colorscheme monokai_ristretto<cr>')
map('n', '<leader>tk', ':colorscheme tokyonight<cr>')

-- buffer navigation
map('n', '<leader>bp', ':bprev<cr>')
map('n', '<leader>bn', ':bnext<cr>')
map('n', '<leader>bd', ':bdelete<cr>')

-- resize with arrows
map('n', '<C-Up>', ':resize -2<CR>')
map('n', '<C-Down>', ':resize +2<CR>')
map('n', '<C-Left>', ':vertical resize -2<CR>')
map('n', '<C-Right>', ':vertical resize +2<CR>')

-- resize with arrows
map('n', '<C-Up>', ':resize -2<CR>')
map('n', '<C-Down>', ':resize +2<CR>')
map('n', '<C-Left>', ':vertical resize -2<CR>')
map('n', '<C-Right>', ':vertical resize +2<CR>')

map('n', 'J', '5j')
map('x', 'J', '5j')
map('n', 'K', '5k')
map('x', 'K', '5k')

map("n", "L", "g_")
map("n", "H", "^")
map("x", "L", "g_")
map("x", "H", "^")

map("n", "W", "5w")
map("n", "B", "5b")


map("n", "<", "<<")
map("n", ">", ">>")
map("x", "<", "<gv")
map("x", ">", ">gv")

-- map("n", ";d", ":Dispatch ", {noremap = true, silent = false})

map("n", "-", "N")
map("n", "=", "n")
-- map("n", ";", ":")
-- map("v", ";", ":")


-- map("n", ",", ":tabnext<CR>")

map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")
map("n", "<C-h>", "<C-w>h")
map("n", "<leader><C-r>", "<C-w>r")

map("", "<Space>", "<Nop>")

map("n", ";w", ":w<CR>")
map("n", ";q", ":q!<CR>")

-- map("n", ";x", ":x<cr>")

map("x", "<C-y>", [["+y]])
map("n", "<C-p>", [["+p]])
map("i", "<C-p>", [[<ESC>"+pa]])

map("n", "<ESC>", ":nohlsearch<CR>")

map("n", "<C-up>", ":res +5<CR>")
map("n", "<C-down>", ":res -5<CR>")
map("n", "<C-right>", ":vertical resize-5<CR>")
map("n", "<C-left>", ":vertical resize+5<CR>")

-- nvim-tree
map("n", "<leader>tt", ":NvimTreeToggle<CR>")
map("n", "<leader>tr", ":NvimTreeRefresh<CR>")

-- vsplit commands
map("n", "<leader><C-b>", ":vsplit<CR>")
map("n", "<C-w>", ":split<CR>")

-- commentary
map("n", "<C-n>", ":CommentToggle<CR>")
map("v", "<C-n>", ":CommentToggle<CR>")

map("n", "tl", ":lua require('telescope.builtin').find_files{}<CR>")
map("n", "tg", "<cmd>Telescope live_grep<cr>")

map("n", "<LEADER>g", [[<CMD>Git<CR>]])
map("n", "<LEADER>l", [[<CMD>LazyGit<CR>]])

-- map("i", "<A-;>", "<ESC>")
map("i", "jj", "<ESC>")
map("i", "JJ", "<ESC>")
map("v", "aa", "<ESC>")
map("i", "jk", "<ESC>")

-- my own line for LExplore
-- map("n", "<LEADER>e", ":Lex 30<CR>")

-- my own line for moving normal texts up and down
-- map("n", "<A-j>", ":m .+1<CR>==gn")
-- map("n", "<A-k>", ":m .-2<CR>==gn")

-- for saving automatically,
-- map("n", ";", ":")
map("n", "<leader>w", ":w!<CR>")
map("n", "<leader>q", ":q!<CR>")

-- my own line for moving blocks of visual texts up and down
-- map("v", "<A-j>", ":m .+1<CR>==gn", opt)
-- map("v", "<A-k>", ":m .-2<CR>==gn", opt)


-- bufferline tab stuff
map("n", "<leader><C-x>", ":BufferLinePickClose<CR>") -- close tab


map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- move tabs
map("n", "<C-c>", [[<CMD>:BufferLinePick<CR>]])

map("n", "<leader>n", "<ESC>:tabnew<CR>")

map("n", "<LEADER>s", [[<ESC>:Startify<CR>]])


--------------------------------------------------------------------
--                   NVTERM CONFIGURATIONS
--------------------------------------------------------------------

map("n", "<leader>tf", "<ESC>:FloatermToggle<CR>")
map("n", "<leader>th", ":lua require('nvterm.terminal').toggle 'horizontal'<cr>")
map("n", "<leader>tv", ":lua require('nvterm.terminal').toggle 'vertical'<cr>")


--------------------------------------------------------------------
--                   END OF NVTERM CONFIGURATIONS
--------------------------------------------------------------------

map("n", "<C-s>", ":wqa!<cr>")
map("i", "<C-s>", "<ESC>:wqa!<cr>")

map("i", "<C-Space>", ":compe#complete()")
map("i", "<CR>",      ":compe#confirm(lexima#expand('<LT>CR>', 'i'))")
map("i", "<C-e>",     ":compe#close('<C-e>')")
map("i", "<C-f>",     ":compe#scroll({ 'delta': +4 })")
-- map("i", "<C-d>",     ":compe#scroll({ 'delta': -4 })")

map("n", "<leader><C-d>", ":only<CR>")


-- map("n", "<leader>ex", ":Ex<cr>")
map("n", ";d", ":bd<cr>")

-- Inspired by the PRIMEAGEN... Copied from the PRIMEAGEN's workflow

map('n', 'gd', ':lua vim.lsp.buf.definition()<cr>')
map('n', 'gD', ':lua vim.lsp.buf.declaration()<cr>')
map('n', 'gi', ':lua vim.lsp.buf.implementation()<cr>')
map('n', 'gsh', ':lua vim.lsp.buf.signature_help()<cr>')
map('n', 'gr', ':lua vim.lsp.buf.references()<cr>')
map('n', 'rn', ':lua vim.lsp.buf.rename()<cr>')

map('n', 'gt', ':lua vim.lsp.buf.type_definition()<cr>')

map('n', 'gw', ':lua vim.lsp.buf.workspace_symbol()<cr>')

map('n', 'gh', ':lua vim.lsp.buf.hover()<cr>')
map('n', 'ca', ':lua vim.lsp.buf.code_action()<cr>')
map('n', 'gsd', ':lua vim.lsp.diagnostic.show_line_diagnostics()<cr>')
map('n', 'gn', ':lua vim.lsp.diagnostic.goto_next()<cr>')
map('n', 'gll', ':call LspLocationList<cr>')

map('n', '<leader><F5>',  ":source ~/.config/nvim/init.lua<cr>")

map('n', '<leader>fa', ':SearchBoxIncSearch<cr>')
map('n', '<leader>fr', ':SearchBoxReplace<cr>')

map('x', '<leader>af', ':SearchBoxIncSearch visual_mode=true<cr>')
map('x', '<leader>ar', ':SearchBoxReplace exact=true visual_mode=true<cr>')

map('n', '<leader><F1>', ":Telescope<cr>")
map('n', '<leader><F2>', ":Telescope colorscheme<cr>")

-- Remapping github copilot
map('i', '<C-i>', "copilot#Accept(<Tab>)",{ expr = true, silent = true, script = true })

-- 2022-12-28 11:13:00

vim.keymap.set('n', '<leader>r', ':RunCode<cr>', { noremap = true, silent = false })
vim.keymap.set('n', '<leader>rf', ':RunFile<cr>', { noremap = true, silent = false })
vim.keymap.set('n', '<leader>rft', ':RunFile tab<cr>', { noremap = true, silent = false })
vim.keymap.set('n', '<leader>rp', ':RunProject<cr>', { noremap = true, silent = false })
vim.keymap.set('n', '<leader>rc', ':RunClose<cr>', { noremap = true, silent = false })
vim.keymap.set('n', '<leader>crf', ':CRFiletype<cr>', { noremap = true, silent = false })
vim.keymap.set('n', '<leader>crp', ':CRProjects<cr>', { noremap = true, silent = false })
