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

######################################################################
#                               PACKAGES
######################################################################

RUN apt-get update -y && apt-get upgrade -y && apt-get install -y \
  clang \
  curl \
  git \
  make \
  pip \
  python3 \
  npm \
  nodejs \
  ripgrep \
  tar \
  wget \
  vim

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
