""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Original Author: Ryan Carney
" License: MIT
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""{{{
let s:save_cpoptions = &cpoptions
set cpoptions&vim

if exists('g:loaded_backup_tree')
    finish
else
    let g:loaded_backup_tree = 1
endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}

" GLOBALS {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:backup_tree =  get(g:, 'backup_tree', '~/.vim_backup')
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}

" AUTOCMDS {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('autocmd')
    augroup backup_tree
        autocmd!
        " TODO added BufEnter due to seeing default backupdir & backupext behavior
        " when using neovim, but may also be a vim problem too. Need to
        " investigate this further.
        autocmd BufEnter,BufWritePre * call backup_tree#setup()
    augroup END
endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}

" COMMANDS {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
command! BackupTree execute ':vsplit ' . g:backup_tree

command! BackupTreeCurrent call backup_tree#open_current_dir()
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""{{{
let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions
" vim:foldmethod=marker
" vim: textwidth=78
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}
