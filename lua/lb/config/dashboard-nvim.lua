-- =====================================================================
--
-- dashboard-nvim.lua - 
--
-- Created by liubang on 2021/04/19 11:15
-- Last Modified: 2021/04/19 11:15
--
-- =====================================================================
vim.g.dashboard_default_executive = 'telescope'
vim.g.dashboard_custom_header = {
  '                                                          ',
  ' ██▓     ██▓ █    ██  ▄▄▄▄    ▄▄▄       ███▄    █   ▄████',
  '▓██▒    ▓██▒ ██  ▓██▒▓█████▄ ▒████▄     ██ ▀█   █  ██▒ ▀█▒',
  '▒██░    ▒██▒▓██  ▒██░▒██▒ ▄██▒██  ▀█▄  ▓██  ▀█ ██▒▒██░▄▄▄░',
  '▒██░    ░██░▓▓█  ░██░▒██░█▀  ░██▄▄▄▄██ ▓██▒  ▐▌██▒░▓█  ██▓',
  '░██████▒░██░▒▒█████▓ ░▓█  ▀█▓ ▓█   ▓██▒▒██░   ▓██░░▒▓███▀▒',
  '░ ▒░▓  ░░▓  ░▒▓▒ ▒ ▒ ░▒▓███▀▒ ▒▒   ▓▒█░░ ▒░   ▒ ▒  ░▒   ▒ ',
  '░ ░ ▒  ░ ▒ ░░░▒░ ░ ░ ▒░▒   ░   ▒   ▒▒ ░░ ░░   ░ ▒░  ░   ░ ',
  '  ░ ░    ▒ ░ ░░░ ░ ░  ░    ░   ░   ▒      ░   ░ ░ ░ ░   ░ ',
  '    ░  ░ ░     ░      ░            ░  ░         ░       ░ ',
  '                           ░                              ',
  '                                                          ',
  '                                                          ',
}
vim.g.dashboard_custom_section = {
  find_file = {
    description = {'  Find File                               SPC ff'},
    command = [[lua require('telescope.builtin').find_files({previewer = false})]],
  },
  find_history = {
    description = {'  Buffers                                 SPC bb'},
    command = [[lua require('telescope.builtin').buffers({previewer = false})]],
  },
  find_word = {
    description = {'  Find word                               SPC ag'},
    command = [[lua require('telescope.builtin').live_grep()]],
  },
  list_tasks = {
    description = {'蘿 List tasks                              SPC ts'},
    command = [[lua require('telescope').extensions.tasks.tasks()]],
  },
  list_bazel_rules = {
    description = {'  List bazel rules                        SPC br'},
    command = [[lua require('telescope').extensions.bazel.bazel_rules()]],
  },
  list_projects = {
    description = {'  List projects                           SPC wo'},
    command = [[lua require('telescope').extensions.project.project({change_dir = true})]],
  },
}
