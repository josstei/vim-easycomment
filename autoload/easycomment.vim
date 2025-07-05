function! easycomment#Comment(lang, start, end) abort
    let l:block = get(a:lang,'block',{})
    let multi   = (a:end - a:start) > 0 

    if multi && !empty(l:block) 
        call easycomment#comment#CommentBlock(a:lang, a:start, a:end)
    else
        call easycomment#comment#CommentLine(a:lang, a:start, a:end)
    endif
endfunction

function! easycomment#Uncomment(config, start, end) abort
    let l:block = get(a:config,'block',{})
    let multi   = (a:end - a:start) > 0 

    if multi && !empty(l:block) 
        let line_start  = getline(a:start)
        let block_start = '^\(\s*\)' . escape(a:config.block.start, '\') . '\s*'
        let first_uncommented = substitute(line_start, block_start, '\1', '')
        call setline(a:start, first_uncommented)
        
        let line_end    = getline(a:end)
         let block_end   = '\s*' . escape(a:config.block.end, '\') . '\s*$'
         let last_uncommented = substitute(line_end, block_end, '', '')
        call setline(a:end, last_uncommented)
    else
        call easycomment#comment#UncommentLine(a:config, a:start, a:end)
    endif
endfunction

function! easycomment#Toggle(start, end) abort
    let lang        = easycomment#lang#Get()
    let lang_block  = get(lang,'block',{})
    let lang_line   = get(lang,'line','')

    let multiline   = (a:end - a:start) > 0 

    let start       = getline(a:start)
    let end         = getline(a:end)

    let blockstart  = ''
    let blockend    = ''

    if multiline && !empty(lang_block)
        let blockstart = '^\s*' . escape(lang.block.start, '\')
        let blockend   = escape(lang.block.end, '\') . '\s*$'
    elseif !empty(lang_line)
        let blockstart = '^\s*' . escape(lang.line, '\')
        let blockend   = ''
    elseif !empty(lang_block)
        let blockstart = '^\s*' . escape(lang.block.start, '\')
        let blockend   = escape(lang.block.end, '\') . '\s*$'
    endif

    if start =~# blockstart && (empty(blockend) || end =~# blockend)
        call easycomment#Uncomment(lang, a:start, a:end)
    else
        call easycomment#Comment(lang, a:start, a:end)
    endif
endfunction
