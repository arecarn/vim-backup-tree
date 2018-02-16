""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Original Author: Ryan Carney
" License: MIT
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""{{{
let s:save_cpoptions = &cpoptions
set cpoptions&vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}

" GLOBALS {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:has_windows = has('win32') || has('win64')
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}

" PRIVATE FUNCTIONS {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:get_backup_tree() abort
    return expand(g:backup_tree)
endfunction
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}

" PUBLIC FUNCTIONS {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! backup_tree#get_dir() abort
    let l:basic_path = expand('%:p:h')
    let l:path = ''

    if s:has_windows
        let l:path_colon_removed = substitute(l:basic_path, ':', '', 'g')
        let l:path = '\' . l:path_colon_removed
    else
        let l:path = l:basic_path
    endif
    return s:get_backup_tree() . l:path
endfunction


function! backup_tree#setup() abort
    if !isdirectory(s:get_backup_tree())
        call mkdir(s:get_backup_tree(), 'p', 0700)
    endif
    let &backupdir=backup_tree#get_dir()
    if !isdirectory(&backupdir)
        call mkdir(&backupdir, 'p', 0700)
    endif
    let &backupext = '_' . strftime('%Y-%m-%d-%H')
endfunction


function! backup_tree#open_current_dir() abort
    let l:backupdir = backup_tree#get_dir()
    if isdirectory(l:backupdir)
        execute ':vsplit ' . l:backupdir
    endif
endfunction


function! backup_tree#remove_backups_of_deleted_files() abort
    " Remove backups of files that no longer exist.
    let l:files = split(globpath(s:get_backup_tree(), '**', 1), '\n')
    let l:files += split(globpath(s:get_backup_tree(), '**/.*', 1), '\n')

    let l:i = len(l:files)
    while l:i > 0
        let l:backup_file = l:files[l:i - 1]
        if isdirectory(l:backup_file)
            call remove(l:files, l:i - 1)
            let l:i = l:i - 2
            continue
        endif

        " See if the real l:backup_file still exists
        let l:real_file = substitute(l:backup_file, escape(s:get_backup_tree(), '\/'), '', 'g')
        let l:real_file = substitute(l:real_file, '_\d\d\d\d-\d\d-\d\d-\d\d$', '', 'g')
        if s:has_windows
            " converts the drive letter from
            let l:real_file = substitute(l:real_file, '\v^\\(\w)(.*)', '\1:\2', 'g')
        endif
        if !filereadable(l:real_file)
            echo l:backup_file
            call delete(l:backup_file)
        endif

        let l:i = l:i -1
    endwhile
endfunction
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""{{{
let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions
" vim:foldmethod=marker
" vim: textwidth=78
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}
