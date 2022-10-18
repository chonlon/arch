sys_apps := "openssh yay"

terminal_apps := "zellij alacritty kitty yakuake neovim vim ranger nnn fzf ripgrep ripgrep-all btop dust htop fd zoxide wget unzip bat exa lsd"

fonts := "noto-fonts-extra noto-fonts-emoji noto-fonts-cjk noto-fonts nerd-fonts-jetbrains-mono nerd-fonts-ibm-plex-mono nerd-fonts-fira-code ttf-sarasa-gothic nerd-fonts-dejavu-sans-mono ttf-symbola"

input := "fcitx-sogoupinyin fcitx-qt5"

user_apps := "google-chrome rofi clash-for-windows-bin copyq"

code_apps := "visual-studio-code-bin sublime-text-4 rustup gcc cmake ninja go httpie curlie docker jetbrains-toolbox gdb "

kde_apps := "layan-kde-git sweet-kde-git kwin-bismuth-bin"

# init home directorys
init-home-env:
  mkdir -p $HOME/1_code
  mkdir -p $HOME/2_download
  mkdir -p $HOME/3_lon
  mkdir -p $HOME/4_test


# install pkg env, including yay, aru cn etc...
init-pkg:
   # if no archlinuxcn found in pacman.conf, add it.
   if ! grep -q "archlinuxcn" /etc/pacman.conf; then \
     printf "\n\n[archlinuxcn]\nServer = https://repo.archlinuxcn.org/\$arch" | sudo tee -a /etc/pacman.conf; \
   fi
   sudo pacman -Syyu
   sudo pacman -S yay
   printf "\n\n[archlinuxcn]\nServer = https://repo.archlinuxcn.org/\$arch" | sudo tee -a /etc/pacman.conf
   yay -S archlinuxcn-keyring

# install apps for arch
install-apps:
  sudo pacman -S {{sys_apps}}
  yay -S {{input}} {{fonts}} {{user_apps}} {{code_apps}} {{terminal_apps}}
  # yay -R gnu-free-fonts

# init my default ssh
init-ssh:
  ssh-keygen

# init my git configs and repos
init-git:
  @ehco "todo setup git"

# init my dotfiles env
init-configs:
  cd dotfiles && just copy_back

install-z4h:
  #!/usr/bin/env bash
  if command -v curl >/dev/null 2>&1; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/romkatv/zsh4humans/v5/install)"
  else
    sh -c "$(wget -O- https://raw.githubusercontent.com/romkatv/zsh4humans/v5/install)"
  fi

install-zsh-plugins:
  #!/usr/bin/zsh
  git clone https://github.com/sukkaw/zsh-proxy.git $ZSH_CUSTOM/plugins/zsh-proxy
  git clone https://github.com/paulirish/git-open.git $ZSH_CUSTOM/plugins/git-open

# setup zsh plugins and configs.
init-zsh:
  just install-z4h
  just install-zsh-plugins

# install kde apps
init-kde:
  yay -S {{kde_apps}}

init-docker:
  yay -S docker
  -sudo groupadd docker
  sudo systemctl enable docker
  sudo systemctl start docker
  sudo usermod -aG docker $USER
  @ echo "please logout and login again to make docker work."

test-all:
  gcc --version
  cmake --version
  docker --version
  rustc --version
  python --version
  go --version

# init my arch.
init:
    just init-pkg
    just install-apps
    just init-ssh
    just init-git
    just init-configs
    just init-zsh
    just init-docker

    just test-all
