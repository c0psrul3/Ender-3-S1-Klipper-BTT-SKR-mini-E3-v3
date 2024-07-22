""
"" See VIM Documentation for filetype detection
"" (http://vimdoc.sourceforge.net/htmldoc/filetype.html#:filetype-indent-on)
""

"" toml syntax
au! BufRead,BufNewFile {*.toml}
\       set filetype=config.toml


