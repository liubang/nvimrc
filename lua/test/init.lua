vim.fn['quickui#menu#reset']()

local lines = {}
table.insert(lines, 'line')
table.insert(lines, 'line')
table.insert(lines, 'line')

local opts = {
  index = -1,
  title = 'Select',
  h = 30,
  w = 50,
}

local idx = vim.fn['quickui#listbox#inputlist'](lines, opts)
print(idx)

-- let content = [
--             \ [ 'echo 1', 'echo 100' ],
--             \ [ 'echo 2', 'echo 200' ],
--             \ [ 'echo 3', 'echo 300' ],
--             \ [ 'echo 4' ],
--             \ [ 'echo 5', 'echo 500' ],
--             \]
-- let opts = {'title': 'select one'}
-- call quickui#listbox#open(content, opts)
-- [x] aaa

local content = {
  { 'echo 1 kdlfjdsal;fjal;k' },
  { 'echo 2 ewrjiqwedsafdsafzdeqrqw' },
  { 'echo 3 eqdsafxcvf;aekqqyutt' },
}
local opts = {
  title = 'select one',
  callback = function(item)
    -- P(item)
  end,
}

local ret = vim.fn['quickui#checkbox#open'](content, opts)
P(ret)

-- local aaa = vim.fn['quickui#core#single_parse'] '[1] echo 1 kdlfjdsal;fjal;k'
-- P(aaa)
local t = { 1, 2, 3 }

print(t[tonumber '2'])

-- let question = "What do you want ?"
-- let choices = "&Apples\n&Oranges\n&Bananas"
--
-- let choice = quickui#confirm#open(question, choices, 1, 'Confirm')
--
-- if choice == 0
-- 	echo "make up your mind!"
-- elseif choice == 3
-- 	echo "tasteful"
-- else
-- 	echo "I prefer bananas myself."
-- endif

local ret = vim.fn['quickui#confirm#open']('What do you want?', '&Ok\n&No', 1, 'Confirm')
print(ret)
