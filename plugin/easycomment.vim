if exists('g:easycomment_loaded')
    finish
else
    let g:easycomment_loaded = 1
endif

command! -range EasyComment call easycomment#Toggle(<line1>, <line2>)
