FROM debian:stable

# Set locale to "en_US.UTF-8" (copied from Postgres Dockerfile)
RUN apt-get update && \
    apt-get install -y \
        locales \
        coreutils \
        build-essential \
        gdb bash-completion \
        manpages-dev \
        man-db \
        git \
        vim \
        python \
        python-pip \
        && \
    rm -rf /var/lib/apt/lists/* && \
    localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 && \
    git clone https://github.com/cadizm/dotfiles.git /dotfiles && \
    pip install dotfiles && \
    dotfiles --sync --force --home=/src --repo=/dotfiles

ENV LANG en_US.utf8

RUN groupadd -r dev --gid=222 && useradd -r -g dev --uid=222 dev

USER dev
