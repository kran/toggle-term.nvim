if exists("g:loaded_toggle_term") 
 finish
endif
let g:loaded_toggle_term = "v1"

function! ToggleTerm#Toggle(height)
    if exists("t:term_win") && win_gotoid(t:term_win)
        let t:term_hight = winheight("")
        hide
        if exists("t:term_org_win")
            call win_gotoid(t:term_org_win)
            exec "resize " . t:org_win_hight
        endif
    else
        let t:term_org_win = win_getid()
        let t:org_win_hight = winheight("")
        botright new

        if exists("t:term_hight") 
            exec "resize " . t:term_hight
        else
            exec "resize " . a:height
        endif


        try
            exec "buffer " . t:term_buf
        catch
            call termopen($SHELL, {"detach": 0})
            let t:term_buf = bufnr("")
        endtry
        startinsert!
        let t:term_win = win_getid()
    endif
endfunction
