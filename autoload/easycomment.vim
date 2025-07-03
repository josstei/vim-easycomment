function! easycomment#BlockComment(config, start, end) abort
    if empty(a:config.block)
        call easycomment#Comment(a:config.line, a:start, a:end)
        return
    endif
    
    let line_start = getline(a:start)
    let first_indent = matchstr(line_start, '^\s*')
    call setline(a:start, first_indent . a:config.block.start . ' ' . substitute(line_start, '^\s*', '', ''))
    
    let last_line = getline(a:end)
    call setline(a:end, last_line . ' ' . a:config.block.end)
endfunction

function! easycomment#BlockUncomment(config, start, end) abort
    if empty(a:config.block)
        call easycomment#Uncomment(a:config.line, a:start, a:end)
        return
    endif
    
    let line_start  = getline(a:start)
    let block_start = '^\(\s*\)' . escape(a:config.block.start, '\') . '\s*'
    let first_uncommented = substitute(line_start, block_start, '\1', '')
    call setline(a:start, first_uncommented)
    
    let line_end    = getline(a:end)
    let block_end   = '\s*' . escape(a:config.block.end, '\') . '\s*$'
    let last_uncommented = substitute(line_end, block_end, '', '')
    call setline(a:end, last_uncommented)
endfunction

function! easycomment#Comment(comment,start, end)
    let space = a:comment =~ '\s$' ? '' : ' '
    for lnum in range(a:start, a:end)
        let line        = getline(lnum)
        let indent      = matchstr(line, '^\s*')
        let content     = substitute(line, '^\s*', '', '')
        let newline     = indent . a:comment . space . content
        call setline(lnum, newline)
    endfor
endfunction

function! easycomment#Uncomment(comment,start, end) abort
    let pattern = '^\(\s*\)' . a:comment . '\s\?'
    for lnum in range(a:start, a:end)
        let line        = getline(lnum)
        let uncommented = substitute(line, pattern, '\1', '')
        call setline(lnum, uncommented)
    endfor
endfunction

function! easycomment#Toggle(start, end) abort
    let lang_config = easycomment#lang#Get()
    let has_block   = (a:end - a:start) > 0 && !empty(lang_config.block)
    
    if has_block 
        let line_start  = getline(a:start)
        let line_end    = getline(a:end)
        let block_start = '^\s*' . escape(lang_config.block.start, '\')
        let block_end   = escape(lang_config.block.end, '\') . '\s*$'
        
        if line_start =~# block_start && line_end =~# block_end
            call easycomment#BlockUncomment(lang_config, a:start, a:end)
        else
            call easycomment#BlockComment(lang_config, a:start, a:end)
        endif
    else
        
        let pattern = '^\s*' . escape(lang_config.line, '\')

        let all_commented = 1
        for lnum in range(a:start, a:end)
            let line = getline(lnum)
            if line =~# '^\s*$'
                continue
            endif
            if line !~# pattern
                let all_commented = 0
                break
            endif
        endfor

        if all_commented
            call easycomment#Uncomment(lang_config.line,a:start, a:end)
        else
            call easycomment#Comment(lang_config.line,a:start, a:end)
        endif
    endif
endfunction
