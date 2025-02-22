# **Neovim Essential Dependencies Documentation**  

This document provides an essential list of dependencies required for a fully functional Neovim setup based on the given configuration. Instructions are provided for **Debian-based** and **Arch-based** systems.

---

## **1. Install Neovim**
### **Debian-based (Ubuntu, Debian, Pop!_OS, etc.)**
```bash
sudo apt update && sudo apt install neovim
```

### **Arch-based (Arch Linux, Manjaro, EndeavourOS, etc.)**
```bash
sudo pacman -Syu neovim
```

For the latest version, you can use **`neovim-git`** from the **AUR**:
```bash
yay -S neovim-git
```

---

## **2. Install Git (Required for Plugin Management)**
### **Debian-based**
```bash
sudo apt install git
```

### **Arch-based**
```bash
sudo pacman -S git
```

---

## **3. Install Compiler & Build Tools**
Some plugins, such as **nvim-treesitter**, require a compiler and essential build tools.

### **Debian-based**
```bash
sudo apt install build-essential
```

### **Arch-based**
```bash
sudo pacman -S base-devel
```

---

## **4. Install Node.js, npm, and Python**
Certain Neovim plugins, such as **Mason, Treesitter, and LSP servers**, require **Node.js**, **npm**, and **Python**.

### **Debian-based**
```bash
sudo apt install nodejs npm python3 python3-pip
```

### **Arch-based**
```bash
sudo pacman -S nodejs npm python python-pip
```

---

## **5. Install Rust (Required for Rustaceanvim)**
### **Debian-based & Arch-based**
Install Rust via [Rustup](https://rustup.rs/):
```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```
Then, reload your shell:
```bash
source $HOME/.cargo/env
```

---

## **6. Install LSP Servers**
LSP servers are needed for **language support** in Neovim. You can install them using **Mason** inside Neovim or manually via package managers.

### **Manually Install Common LSP Servers**
#### **Debian-based**
```bash
sudo npm install -g pyright
sudo npm install -g bash-language-server
sudo apt install clang
```

#### **Arch-based**
```bash
sudo npm install -g pyright
sudo npm install -g bash-language-server
sudo pacman -S clang
```

For additional LSPs, you can install them inside Neovim:
1. Open Neovim and run:
   ```
   :Mason
   ```
2. Use Mason UI to install required LSPs.

---

## **7. Install Debugging Tools (DAP Support)**
For debugging support with `nvim-dap`, install **Delve** (for Go), **LLDB** (for C/C++/Rust), and other required tools.

### **Debian-based**
```bash
sudo apt install lldb
```

### **Arch-based**
```bash
sudo pacman -S delve lldb
```

---

## **8. Install Nerd Fonts (Required for Icons)**
To ensure correct display of icons in plugins like `nvim-web-devicons`, install a **Nerd Font**.

### **Debian-based**
```bash
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip
unzip FiraCode.zip
rm FiraCode.zip
fc-cache -fv
```

### **Arch-based**
```bash
sudo pacman -S ttf-nerd-fonts-symbols
```

Alternatively, download fonts from [NerdFonts](https://www.nerdfonts.com/) and install them manually.

---

## **9. Install Fuzzy Finder Dependencies (For Telescope)**
### **Debian-based**
```bash
sudo apt install ripgrep fd-find
```
Ensure `fd` is correctly named:
```bash
ln -s $(which fdfind) ~/.local/bin/fd
```

### **Arch-based**
```bash
sudo pacman -S ripgrep fd
```

---

## **10. Final Steps**
After installing the necessary dependencies, open **Neovim** and run:
```vim
:PackerSync  " If using packer
:Lazy sync   " If using lazy.nvim
```
This will ensure all plugins are properly installed.

---

## **Conclusion**
Following these steps will ensure your Neovim setup works smoothly with all essential plugins. 🚀
