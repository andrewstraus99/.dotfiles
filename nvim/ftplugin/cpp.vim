" https://chmanie.com/post/2020/07/17/modern-c-development-in-neovim/
set tabstop=2		        " number of columns occupied by a tab
set shiftwidth=2	        " width for autoindents

" c++ syntax highlighting
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1

" c++ lint
let g:syntastic_cpp_checkers = ['cpplint']
let g:syntastic_c_checkers = ['cpplint']
let g:syntastic_cpp_cpplint_exec = 'cpplint'
" The following two lines are optional. Configure it to your liking!
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" rebind :f to cpp format
nnoremap <Leader>f :<C-u>ClangFormat<CR>

