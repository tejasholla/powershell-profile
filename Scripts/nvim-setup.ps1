# nvim_setup_windows

# Install node
scoop install nodejs

# Install ripgrep
scoop install ripgrep

# Install fd
scoop install fd

# Install lazygit
scoop install lazygit

# Install universal-ctags
scoop bucket add extras
scoop install universal-ctags

# Install vim-language-server
npm install -g vim-language-server

# Install bash-language-server
npm install -g bash-language-server

# Install miniconda3 (for Python)
scoop install miniconda3

# Install pynvim
pip install -U pynvim

# Install python-language-server
pip install 'python-lsp-server[all]' pylsp-mypy python-lsp-isort

# Install visual c++ redistribution
scoop install vcredist2022

# Install 7zip
scoop install 7zip

# Install lua-language-server
$lua_ls_link = "https://github.com/LuaLS/lua-language-server/releases/download/3.6.11/lua-language-server-3.6.11-win32-x64.zip"
$lua_ls_install_dir = "D:\portable_tools"
$lua_ls_src_path = "$lua_ls_install_dir\lua-language-server.zip"
$lua_ls_dir = "$lua_ls_install_dir\lua-language-server"

# Download file, ref: https://stackoverflow.com/a/51225744/6064933
Invoke-WebRequest $lua_ls_link -OutFile "$lua_ls_src_path"

# Extract the zip file using 7zip, ref: https://stackoverflow.com/a/41933215/6064933
7z x "$lua_ls_src_path" -o"$lua_ls_dir"

# Setup PATH env variable, ref: https://stackoverflow.com/q/714877/6064933
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";$lua_ls_dir\bin", "Machine")

# Install neovim nightly
scoop bucket add versions
# install/upgrade neovim
try {
    scoop install neovim
    scoop update neovim
}
catch {
    Write-Error "Failed to install/upgrade neovim. Error: $_"
}


# Required: Backup the existing Neovim configuration
try {
    Move-Item $env:LOCALAPPDATA\nvim $env:LOCALAPPDATA\nvim.bak -Force
}
catch {
    Write-Error "Failed to backup the existing Neovim configuration. Error: $_"
}

# Optional but recommended: Backup the existing Neovim data and clone LazyVim starter
try {
    Move-Item $env:LOCALAPPDATA\nvim-data $env:LOCALAPPDATA\nvim-data.bak -Force
}
catch {
    Write-Error "Failed to backup the existing Neovim data. Error: $_"
}

try {
    git clone https://github.com/LazyVim/starter $env:LOCALAPPDATA\nvim
    Remove-Item $env:LOCALAPPDATA\nvim\.git -Recurse -Force
}
catch {
    Write-Error "Failed to clone LazyVim starter or remove .git folder. Error: $_"
}

# git clone --depth=1 https://github.com/jdhao/nvim-config.git .