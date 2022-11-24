let text =<< lua END
require("telescope").setup({
            \ defaults = {
          \   path_display={'smart'},
      \   preview=false,
      \   border=false,
      \   layout_config={
      \       prompt_position='bottom',
      \   
},
      \   initial_mode='normal',
      \   sorting_strategy='ascending',
      \   color_devicons=false,
      \   mappings={
      \       n={
      \         ["<C-n>"] = require('telescope.actions').move_selection_next,
      \         ["<C-p>"] = require('telescope.actions').move_selection_previous,
      \         ["<C-c>"] = require('telescope.actions').close,
      \         ["p"]     = require('telescope.actions').close,
      \         ["/"]     = { 'i', type='command'  },
      \       
},
            \       i={
      \         ["<C-]>"] = require('telescope.actions').close
      \       
}
      \   
},
      \ 
    },
                \ pickers={
                \     file_browser={
          \         path_display = function(opts, path)
          \             local dir = ''
          \             for w in string.gmatch(path, "[^/]+") do
          \                dir = w
          \             end
          \             return dir
          \         end,
          \         mappings={
          \             n = {
              \                 ["~"] = function(prompt_bufnr)
          \                     require('telescope.builtin').file_browser({cwd='~'})
          \                 end,
          \                 ["<C-w>"] = function(prompt_bufnr)
          \                     local current_path = require('telescope.actions.state').get_current_picker(prompt_bufnr).cwd
          \                     local parent_path = require('plenary.path'):new(current_path):parent():absolute()
          \                     require('telescope.builtin').file_browser({cwd=parent_path})
          \                 end
          \             
        },
                    \             i = {
                  \                 ["~"] = function(prompt_bufnr)
              \                     require('telescope.builtin').file_browser({cwd='~'})
              \                 end,
              \                 ["<C-w>"] = function(prompt_bufnr)
              \                     local current_path = require('telescope.actions.state').get_current_picker(prompt_bufnr).cwd
              \                     local parent_path = require('plenary.path'):new(current_path):parent():absolute()
              \                     require('telescope.builtin').file_browser({cwd=parent_path})
              \                 end
              \             
            }
                  \         
    }
          \     
    }
          \ 
    }
          \ 
})
nnoremap <silent><leader>k :<C-u>lua require('telescope.builtin').git_files({
      \ cwd=vim.fn.expand('%:h'),
      \ 
})<cr>

nnoremap <silent> <Leader>g :<C-u>lua require('telescope.builtin').grep_string({
      \ cwd=vim.fn.FugitiveWorkTree(),
      \ search=vim.fn.expand('<cword>'),
      \ 
})<cr>

command! -nargs=? Gitgrep :lua require('telescope.builtin').grep_string({
      \ cwd=vim.fn.FugitiveWorkTree(),
      \ search='<args>',
      \ 
})

nnoremap <silent> <Leader>b :<C-u>lua require('telescope.builtin').buffers({})<cr>
nnoremap <silent> <Leader>f :<C-u>lua require('telescope.builtin').file_browser({
      \ cwd=vim.fn.expand('%:h'),
      \ 
})<cr>

nnoremap <silent> <Leader>m :<C-u>lua require('telescope.builtin').oldfiles()<cr>
nnoremap <silent> <Leader>ta :<C-u>lua require('telescope.builtin').treesitter({
      \ preview=true,
      \ 
})<cr>

nnoremap <silent> <Leader>p : <C-u>lua require('telescope.builtin').resume()<cr>
END
