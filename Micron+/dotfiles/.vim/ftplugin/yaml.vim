au! BufRead,BufNewFile {*.yaml,*.yml}  doau Yaml

augroup Yaml
    au!
    autocmd FileType yaml
        \ setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
        \          nofoldenable foldmethod=expr foldlevel=0 conceallevel=2
        \          foldexpr=getline(v\:lnum)=~'^\"\"'?'>'.(matchend(getline(v\:lnum),'\"\"*')-2)\:'='
        \ | colorscheme molokai
augroup END

