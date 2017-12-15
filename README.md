# vimrc
my private vim configuration.


![screenshot](./screenshot/1.png)
![screenshot](./screenshot/2.png)


## install 

```shell
git clone https://github.com/iliubang/vimrc.git ~/.vim.rc
ln -s ~/.vim.rc/init.vim ~/.vimrc
vim +PlugInstall +qa
```

## Usage

**About Leader Key**

The `<leader>` key is mapped to '\<Space>'.


```
| Command    | Description                  |
|------------+------------------------------|
| <leader>ff | search files in current path |
| <leader>f? | search files in root path    |
| <leader>ft | toggle nerdtree              |
| F4         | toggle nerdtree              |
| <leader>tm | toggle vim table mode        |
```
