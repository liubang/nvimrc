## Build

```bash
docker build -t nvim .
```

## Run

```bash
docker run -it --rm -v $(pwd):/home/neovim/src nvim
```
