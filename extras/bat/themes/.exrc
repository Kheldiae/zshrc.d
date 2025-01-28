autocmd BufWritePost,FileWritePost *.jsonnet !jsonnet -S % > $(basename % .jsonnet).tmThemes
