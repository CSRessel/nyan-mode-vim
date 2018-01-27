
if !has("gui_running") | finish | endif

if exists("b:loaded_nyanbar") | finish | endif
  let b:loaded_nyanbar = 1

let s:loaded = 0
let s:nyanbars = 0

function! s:nyan_refreshbar()
  if !s:loaded
    return
  endif
  let which = line('.') * 10 / line('$')

  if which > s:nyanbars
    aunmenu ToolBar.Nyan
    while which > s:nyanbars
      execute "amenu <silent> icon=$HOME/.vim/bundle/nyan-mode-vim/img/rainbow.xpm ToolBar.Rainbow" .  s:nyanbars . " :<CR>"
      let s:nyanbars += 1
    endwhile
    execute "amenu <silent> icon=$HOME/.vim/bundle/nyan-mode-vim/img/nyan.xpm ToolBar.Nyan :<CR>"
  elseif which < s:nyanbars
    aunmenu ToolBar.Nyan
    while which < s:nyanbars
	  echo s:nyanbars
      execute "aunmenu <silent> ToolBar.Rainbow" . (s:nyanbars - 1)
      let s:nyanbars -= 1
    endwhile
    execute "amenu <silent> icon=$HOME/.vim/bundle/nyan-mode-vim/img/nyan.xpm ToolBar.Nyan :<CR>"
  endif
endfunction

function! s:nyan_init()
  if s:loaded
    return
  endif
  let s:loaded = 1

  aunmenu *
  autocmd CursorMoved,CursorMovedI * call s:nyan_refreshbar()
  call s:nyan_refreshbar()
  "amenu ToolBar.nyan ... :<CR>
endfunction

call s:nyan_init()

