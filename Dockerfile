FROM debian:stable

# Set locale to "en_US.UTF-8" (copied from Postgres Dockerfile)
RUN apt-get update && \
    apt-get install -y \
        locales \
        coreutils \
        build-essential \
        cmake \
        gdb bash-completion \
        manpages-dev \
        man-db \
        git \
        vim \
        python \
        python-pip \
        python3 \
        python3-pip \
        libboost-all-dev \
        && \
    rm -rf /var/lib/apt/lists/* && \
    localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 && \
    git clone https://github.com/cadizm/bin.git /home/dev/bin && \
    git clone https://github.com/cadizm/dotfiles.git /dotfiles && \
    pip install dotfiles && \
    dotfiles --sync --force --home=/home/dev --repo=/dotfiles

ENV LANG en_US.utf8

RUN git clone https://github.com/google/googletest.git /googletest && \
    mkdir -p /googletest/build && cd /googletest/build && cmake /googletest && make && \
    pip install cpplint

RUN groupadd -r dev --gid=222 && useradd -r -g dev --uid=222 dev

USER dev
