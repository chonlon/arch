

terminal_apps := "zellij alacritty kitty yakuake neovim vim ranger nnn fzf ripgrep ripgrep-all btop dust htop fd zoxide wget unzip "

fonts := "noto-fonts-extra noto-fonts-emoji noto-fonts-cjk noto-fonts nerd-fonts-jetbrains-mono nerd-fonts-ibm-plex-mono nerd-fonts-fira-code ttf-sarasa-gothic nerd-fonts-dejavu-sans-mono"

input := "fcitx-sogoupinyin fcitx-qt5"

user_apps := "google-chrome rofi clash-for-windows-bin copyq"

code_apps := "code-bin sublime-text-4 rustup gcc cmake ninja go httpie curlie docker jetbrains-toolbox gdb "

kde_apps := "kwin-scripts-krohnkite-git"


# install pkg env, including yay, aru cn etc...
init-pkg:
   yay -S archlinuxcn-keyring
   sudo echo "\n\n[archlinuxcn]\nServer = https://repo.archlinuxcn.org/$arch" >> /etc/pacman.conf

# install apps for arch
install-apps:
  yay -S {{input}} {{fonts}} {{user_apps}} {{code_apps}} {{terminal_apps}}

# init my default ssh
init-ssh:
  ssh-gen

# init my git configs and repos
init-git:
  @ehco "todo setup git"

# init my dotfiles env
init-configs:
  just -f dotfiles/Justfile

init-services:

install-z4h:
  if command -v curl >/dev/null 2>&1; then \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/romkatv/zsh4humans/v5/install)" \
  else \
    sh -c "$(wget -O- https://raw.githubusercontent.com/romkatv/zsh4humans/v5/install)" \
  fi

# setup zsh plugins and configs.
init-zsh:
 @echo "todo"

# install kde apps
init-kde:
  yay -S {{kde_apps}}  

init-docker:

# init my arch.
init:
    

# update my arch configs.
update:

