FROM ubuntu:noble-20241118.1

ENV NEOVIM_RELEASE_VERSION="v0.10.1"
ENV NEOVIM_SHA256="4867de01a17f6083f902f8aa5215b40b0ed3a36e83cc0293de3f11708f1f9793"

RUN apt-get update -y && apt-get upgrade -y && apt-get install -y \
  clang \
  curl \
  #gcc \
  tar \
  wget \
  vim

######################################################################
#                               NEOVIM
######################################################################
RUN mkdir -p /tmp/neovim
WORKDIR /tmp/neovim
# For some reason -O is not passing the checksum
RUN curl -L "https://github.com/neovim/neovim/releases/download/${NEOVIM_RELEASE_VERSION}/nvim-linux64.tar.gz" -o nvim-linux64.tar.gz && \
  echo "${NEOVIM_SHA256} nvim-linux64.tar.gz" | sha256sum -c - && \
  tar -xzf nvim-linux64.tar.gz && \
  mv nvim-linux64 /opt/nvim
ENV PATH="$PATH:/opt/nvim/bin"

