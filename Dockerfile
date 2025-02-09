######################################################################
#               _            _
#            __| | _____   _| |__   _____  __
#           / _` |/ _ \ \ / | '_ \ / _ \ \/ /
#          | (_| |  __/\ V /| |_) | (_) >  <
#           \__,_|\___| \_/ |_.__/ \___/_/\_\
#
######################################################################

FROM ubuntu:noble-20241118.1

ENV USERNAME="duncan"
ENV NEOVIM_RELEASE_VERSION="0.10.1"
ENV NEOVIM_SHA256="4867de01a17f6083f902f8aa5215b40b0ed3a36e83cc0293de3f11708f1f9793"
ENV LAZYGIT_VERSION="0.44.1"
ENV YAZI_VERSION="0.4.1"
ENV GIT_USERNAME="duncanam"
ENV GIT_EMAIL="22781288+duncanam@users.noreply.github.com"
ENV GIT_DEFAULT_BRANCH="main"
ENV TZ="America/Los_Angeles"

######################################################################
#                               PACKAGES
######################################################################

RUN apt-get update -y && apt-get upgrade -y && apt-get install -y \
  clang \
  curl \
  fd-find \
  fontconfig \
  git \
  luarocks \
  make \
  pip \
  python3 \
  npm \
  nodejs \
  ripgrep \
  sudo \
  tar \
  unzip \
  wget \
  vim \
  zsh

RUN chsh -s $(which zsh)

RUN useradd -ms /bin/zsh ${USERNAME}
RUN usermod -aG sudo ${USERNAME}
USER ${USERNAME}

RUN mkdir -p ~/.local/share/fonts
WORKDIR /home/${USERNAME}/.local/share/fonts
RUN curl -L "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/JetBrainsMono.zip" -o JetBrainsMono.zip && \
  unzip JetBrainsMono.zip && \
  rm JetBrainsMono.zip && \
  fc-cache -fv

######################################################################
#                               ZSH
######################################################################

# TODO: this seems odd that I have to specifically run this as root
USER root
COPY .config/.zshrc /home/${USERNAME}/.zshrc
RUN chmod a+rwx /home/${USERNAME}/.zshrc
COPY .config/.p10k.zsh /home/${USERNAME}/.p10k.zsh
RUN chmod a+rwx /home/${USERNAME}/.p10k.zsh
USER ${USERNAME}

RUN  echo 'export SHELL="/bin/zsh"' >> /home/${USERNAME}/.zshrc
RUN git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
RUN git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.powerlevel10k

######################################################################
#                               RUST
######################################################################

#RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
#RUN ~/.cargo/bin/cargo install \
#  cargo-nextest \
#  ripgrep
#RUN ~/.cargo/bin/rustup component add rustfmt

######################################################################
#                               LAZYGIT
######################################################################

RUN mkdir -p /tmp/lazygit
WORKDIR /tmp/lazygit
RUN curl -L "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz" -o lazygit.tar.gz && \
  tar -xzf lazygit.tar.gz && \
  mkdir -p ~/bin && \
  mv lazygit ~/bin/lazygit
ENV PATH="$PATH:~/bin"
RUN echo 'export PATH="$PATH:/home/'"${USERNAME}"'/bin"' >> ~/.zshrc
RUN mkdir -p ~/.config/lazygit && \
  echo "disableStartupPopups: true" >> ~/.config/lazygit/config.yml
RUN git config --global user.name ${GIT_USERNAME} && \
  git config --global user.email ${GIT_EMAIL} && \
  git config --global init.defaultbranch ${GIT_DEFAULT_BRANCH} && \
  git config --global core.editor "nvim"

######################################################################
#                               YAZI
######################################################################

RUN mkdir -p /tmp/yazi
WORKDIR /tmp/yazi
RUN curl -L "https://github.com/sxyazi/yazi/releases/download/v${YAZI_VERSION}/yazi-x86_64-unknown-linux-gnu.zip" -o yazi.zip && \
  unzip yazi.zip && \
  mv yazi-x86_64-unknown-linux-gnu ~/bin/yazi
ENV PATH="$PATH:~/bin/yazi"
RUN echo 'export PATH="$PATH:/home/'"${USERNAME}"'/bin/yazi"' >> ~/.zshrc
COPY scripts/yazi-cd.sh /tmp/yazi/
RUN cat yazi-cd.sh >> ~/.zshrc

######################################################################
#                               NEOVIM
######################################################################

RUN mkdir -p /tmp/neovim
WORKDIR /tmp/neovim
# For some reason -O is not passing the checksum
RUN curl -L "https://github.com/neovim/neovim/releases/download/v${NEOVIM_RELEASE_VERSION}/nvim-linux64.tar.gz" -o nvim-linux64.tar.gz && \
  echo "${NEOVIM_SHA256} nvim-linux64.tar.gz" | sha256sum -c - && \
  tar -xzf nvim-linux64.tar.gz && \
  mv nvim-linux64 ~/bin/nvim
ENV PATH="$PATH:~/bin/nvim/bin"
RUN echo 'export PATH="$PATH:/home/'"${USERNAME}"'/bin/nvim/bin"' >> ~/.zshrc

RUN git clone https://github.com/NvChad/starter ~/.config/nvim

# TODO: even though this is on the path, it can't find it?
RUN ~/bin/nvim/bin/nvim --headless +Lazy sync +qall
RUN ~/bin/nvim/bin/nvim --headless -c "MasonInstallAll" +qall


######################################################################
#                               FINISH
######################################################################
WORKDIR /home/${USERNAME}
ENTRYPOINT [ "/bin/zsh" ]
