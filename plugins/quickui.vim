"======================================================================
"
" quickui.vim - 
"
" Created by liubang on 2020/05/17
" Last Modified: 2020/05/17 19:30
"
"======================================================================


" copied from https://github.com/skywind3000/vim
function! MenuHelp_TaskList()
  let keymaps = '123456789abcdefimnopqrstuvwxyz'
  let items = asynctasks#list('')
  let rows = []
  let size = strlen(keymaps)
  let index = 0
  for item in items 
    if item.name =~ '^\.'
      continue
    endif
    let cmd = strpart(item.command, 0, (&columns * 60) / 100)
    let key = (index >= size)? ' ' : strpart(keymaps, index, 1)
    let text = "[" . ((key != ' ')? ('&' . key) : ' ') . "]\t"
    let text .= item.name . "\t[" . item.scope . "]\t" . cmd
    let rows += [[text, 'AsyncTask ' . fnameescape(item.name)]]
    let index += 1
  endfor
  let opts = {}
  let opts.title = 'Task List'
  call quickui#tools#clever_listbox('tasks', rows, opts)
endfunc

if exists('*nvim_open_win') > 0
  call quickui#menu#reset()
  call quickui#menu#install('&File', [
        \ [ "&Open\t(:e)", 'call feedkeys(":e ")' ],
        \ [ "&Save\t(:w)", 'write' ],
        \ [ "--", ],
        \ [ "&Outline\t<Leader>tl", 'Vista!!', '' ],
        \ [ "File &Explorer", 'Defx', 'Taggle file exporer' ],
        \ [ "Switch &Files", 'Files .' ],
        \ [ "Switch &Buffers", 'call quickui#tools#list_buffer("e")' ],
        \ [ "--", ],
        \ [ "E&xit", 'qa' ],
        \ ])

  call quickui#menu#install('&Edit', [
        \ [ "&Find\t<Leader>ag", 'Rg', '' ],
        \ [ "&Trailing Space", 'call utils#strip_trailing_whitespace()', '' ],
        \ [ "--", ],
        \ [ 'Update &ModTime', 'call comment#update()' ],
        \ [ '&CopyRight', 'call comment#copyright("liubang")' ],
        \ [ "Taggle Co&mment\t<Leader>cc", 'call feedkeys("\<Plug>NERDCommenterToggle")' ],
        \ [ "--", ],
        \ [ "&Hex Edit", 'Vinarise', 'Ultimate hex editing system with Vim' ],
        \ ])

  call quickui#menu#install('&Build', [
        \ [ "File &Execute\t<Ctrl-r>", 'AsyncTask file-run' ],
        \ [ "File &Compile\t<Ctrl-b>", 'AsyncTask file-build' ],
        \ [ "Compile And E&xecute\t<Ctrl-x>", 'AsyncTask file-build-and-run' ],
        \ [ '--','' ],
        \ [ "&BazelBuild\t<Leader>bz", 'BazelBuild' ],
        \ [ "Bazel&Run\t<Leader>br", 'BazelRun' ],
        \ [ "Bazel&UpdateTargets\t<Leader>bu", 'BazelUpdateTargets' ],
        \ [ '--','' ],
        \ [ "&Task List\t<Leader>ts", 'call MenuHelp_TaskList()' ],
        \ [ '--','' ],
        \ [ "Clang &Format\t<Leader>cf", 'ClangFormat' ],
        \ ])

  call quickui#menu#install('&Tools', [
        \ [ "View &Diff", 'Gdiffsplit' ], 
        \ [ "Show &Log", 'Gclog' ],
        \ [ "Git &Blame", 'Gblame' ],
        \ [ '--', '' ],
        \ [ "List &Function", 'call quickui#tools#list_function()', '' ],
        \ [ "&Choose Window/Tab", 'ChooseWin', '' ],
        \ [ "Display Ca&lendar", 'Calendar -first_day=monday', '' ],
        \ [ "Ter&minal", 'FloatermToggle', '' ],
        \ [ '--', '' ],
        \ [ "Plugin &Update", 'PlugUpdate', '' ],
        \ [ "Plugin &Clean", 'PlugClean', '' ],
        \ ])

  call quickui#menu#install('Help (&?)', [
        \ [ "&Cheatsheet", 'help index', '' ],
        \ [ 'T&ips', 'help tips', '' ],
        \ [ '--','' ],
        \ [ "&Tutorial", 'help tutor', '' ],
        \ [ '&Quick Reference', 'help quickref', '' ],
        \ [ '&Summary', 'help summary', '' ],
        \ [ '--','' ],
        \ [ "&Vim Script", 'help eval', '' ], 
        \ [ "&Function List", 'help function-list', '' ],
        \ ], 10000)
  let g:quickui_color_scheme = 'gruvbox'
  let g:quickui_border_style = 2
  " let g:quickui_show_tip = 1
endif
