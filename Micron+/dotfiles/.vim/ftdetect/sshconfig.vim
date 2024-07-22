""
"" See VIM Documentation for filetype detection
"" (http://vimdoc.sourceforge.net/htmldoc/filetype.html#:filetype-indent-on)
""

"" SSH_Config
au! BufRead,BufNewFile {*/.ssh/config,ssh_config.*}
\       set filetype=sshconfig

