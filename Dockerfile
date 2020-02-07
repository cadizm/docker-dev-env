FROM debian:stretch

# Set locale to "en_US.UTF-8" (copied from Postgres Dockerfile)
RUN apt-get update -y && \
    apt-get install -y \
        ack-grep \
        bash-completion \
        build-essential \
        cmake \
        coreutils \
        curl \
        default-jdk \
        exuberant-ctags \
        gdb \
        git \
        id-utils \
        locales \
        man-db \
        manpages-dev \
        pkg-config \
        python \
        python-pip \
        python3 \
        python3-pip \
        unzip \
        vim \
        wget \
        xz-utils \
        zip \
        zlib1g-dev \
        && \
    rm -rf /var/lib/apt/lists/* && \
    localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 && \
    git clone https://github.com/google/googletest.git /googletest && \
    mkdir -p /googletest/build && cd /googletest/build && cmake /googletest && make && \
    pip3 install cpplint

ENV LANG en_US.utf8

RUN git clone https://github.com/cadizm/bin.git /home/dev/bin && \
    git clone https://github.com/cadizm/dotfiles.git /dotfiles && \
    pip3 install dotfiles && \
    dotfiles --sync --force --home=/home/dev --repo=/dotfiles

RUN groupadd -r dev --gid=222 && useradd -r -g dev --uid=222 dev && \
    chown -R dev:dev ~dev

USER dev
