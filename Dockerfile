######################################################################
#               _            _
#            __| | _____   _| |__   _____  __
#           / _` |/ _ \ \ / | '_ \ / _ \ \/ /
#          | (_| |  __/\ V /| |_) | (_) >  <
#           \__,_|\___| \_/ |_.__/ \___/_/\_\
#
######################################################################

FROM ubuntu:noble-20241118.1

ENV NEOVIM_RELEASE_VERSION="0.10.1"
ENV NEOVIM_SHA256="4867de01a17f6083f902f8aa5215b40b0ed3a36e83cc0293de3f11708f1f9793"
ENV LAZYGIT_VERSION="0.44.1"
ENV YAZI_VERSION="0.4.1"
ENV GIT_USERNAME="duncanam"
ENV GIT_EMAIL="22781288+duncanam@users.noreply.github.com"
ENV GIT_DEFAULT_BRANCH="main"

######################################################################
#                               PACKAGES
######################################################################

RUN apt-get update -y && apt-get upgrade -y && apt-get install -y \
  clang \
  curl \
  fontconfig \
  git \
  luarocks \
  make \
  pip \
  python3 \
  npm \
  nodejs \
  ripgrep \
  tar \
  unzip \
  wget \
  vim

RUN mkdir -p /root/.local/share/fonts
WORKDIR /root/.local/share/fonts
RUN curl -L "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/JetBrainsMono.zip" -o JetBrainsMono.zip && \
  unzip JetBrainsMono.zip && \
  rm JetBrainsMono.zip && \
  fc-cache -fv

######################################################################
#                               RUST
######################################################################

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
RUN /root/.cargo/bin/cargo install \
  cargo-nextest \
  ripgrep
RUN /root/.cargo/bin/rustup component add rustfmt

######################################################################
#                               LAZYGIT
######################################################################

RUN mkdir -p /tmp/lazygit
WORKDIR /tmp/lazygit
RUN curl -L "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz" -o lazygit.tar.gz && \
  tar -xzf lazygit.tar.gz && \
  mkdir -p /opt/lazygit/bin && \
  mv lazygit /opt/lazygit/bin/lazygit
ENV PATH="$PATH:/opt/lazygit/bin"
RUN mkdir -p /root/.config/lazygit && \
  echo "disableStartupPopups: true" >> /root/.config/lazygit/config.yml
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
  mv yazi-x86_64-unknown-linux-gnu /opt/yazi
ENV PATH="$PATH:/opt/yazi"
COPY scripts/yazi-cd.sh /tmp/yazi/
RUN cat yazi-cd.sh >> /root/.bashrc

######################################################################
#                               NEOVIM
######################################################################

RUN mkdir -p /tmp/neovim
WORKDIR /tmp/neovim
# For some reason -O is not passing the checksum
RUN curl -L "https://github.com/neovim/neovim/releases/download/v${NEOVIM_RELEASE_VERSION}/nvim-linux64.tar.gz" -o nvim-linux64.tar.gz && \
  echo "${NEOVIM_SHA256} nvim-linux64.tar.gz" | sha256sum -c - && \
  tar -xzf nvim-linux64.tar.gz && \
  mv nvim-linux64 /opt/nvim
ENV PATH="$PATH:/opt/nvim/bin"
RUN echo "export EDITOR=nvim" >> /root/.bashrc && \
  alias n="neovim"

COPY .config /root/.config

RUN nvim --headless +Lazy sync +qall
RUN nvim --headless -c "MasonInstallAll" +qall

######################################################################
#                               FINISH
######################################################################
WORKDIR /root
RUN bash
