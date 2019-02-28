FROM debian:stable

# Set locale to "en_US.UTF-8" (copied from Postgres Dockerfile)
RUN apt-get update && \
    apt-get install -y \
        ack-grep \
        bash-completion \
        build-essential \
        cmake \
        coreutils \
        curl \
        exuberant-ctags \
        gdb \
        git \
        id-utils \
        locales \
        man-db \
        manpages-dev \
        openjdk-8-jdk \
        pkg-config \
        python \
        python-pip \
        python3 \
        python3-pip \
        unzip \
        vim \
        wget \
        zip \
        zlib1g-dev \
        && \
    rm -rf /var/lib/apt/lists/* && \
    localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 && \
    dpkg-divert --local --divert /usr/bin/ack --rename --add /usr/bin/ack-grep && \
    git clone https://github.com/google/googletest.git /googletest && \
    mkdir -p /googletest/build && cd /googletest/build && cmake /googletest && make && \
    pip install cpplint

ENV LANG en_US.utf8

ADD https://github.com/bazelbuild/bazel/releases/download/0.23.0/bazel_0.23.0-linux-x86_64.deb /tmp/

RUN apt install /tmp/bazel_0.23.0-linux-x86_64.deb && \
    git clone https://github.com/cadizm/bin.git /home/dev/bin && \
    git clone https://github.com/cadizm/dotfiles.git /dotfiles && \
    pip install dotfiles && \
    dotfiles --sync --force --home=/home/dev --repo=/dotfiles

RUN groupadd -r dev --gid=222 && useradd -r -g dev --uid=222 dev && \
    chown -R dev:dev ~dev

USER dev
