""
"" See VIM Documentation for filetype detection
"" (http://vimdoc.sourceforge.net/htmldoc/filetype.html#:filetype-indent-on)
""

"" YAML syntax
au! BufRead,BufNewFile {*.yaml,*.yml}
\       set filetype=yaml

""
""  ## VIM Setup for Yaml files
""  ===========================
""
""  Put the following lines in ~/.vimrc:
""
""  ```
""  " Yaml file handling
""  autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
""  filetype plugin indent on
""  autocmd FileType yaml setl indentkeys-=<:>
""
""  " Copy paste with ctr+c, ctr+v, etc
""  :behave mswin
""  :set clipboard=unnamedplus
""  :smap <Del> <C-g>"_d
""  :smap <C-c> <C-g>y
""  :smap <C-x> <C-g>x
""  :imap <C-v> <Esc>pi
""  :smap <C-v> <C-g>p
""  :smap <Tab> <C-g>1>
""  :smap <S-Tab> <C-g>1<
""

