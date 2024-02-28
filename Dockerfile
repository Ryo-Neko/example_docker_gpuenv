FROM nvidia/cuda:11.7.1-devel-ubuntu20.04

RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

RUN apt-get -y update \
    && apt-get -y upgrade
RUN apt-get install -y build-essential 
RUN apt-get install -y libffi-dev libssl-dev zlib1g-dev \
                        liblzma-dev libbz2-dev \
                        libreadline-dev libsqlite3-dev libopencv-dev tk-dev git wget
RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ARG USERNAME ""
ARG GROUPNAME ""
ARG USERID ""
ARG GROUPID ""

ENV APPDIR "/app"
ENV HOME /home/$USERNAME

RUN groupadd -g $GROUPID $GROUPNAME
RUN useradd -u $USERID -g $GROUPID -d $HOME -s /bin/bash $USERNAME


RUN mkdir $APPDIR && chown -R $USERNAME:$GROUPNAME $APPDIR \
                  && mkdir $HOME && chown -R $USERNAME:$GROUPNAME $HOME

WORKDIR $APPDIR
USER $USERNAME

ENV PYENV_ROOT "${APPDIR}/.pyenv"
ENV PATH "$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH"
RUN git clone https://github.com/pyenv/pyenv.git $PYENV_ROOT
RUN eval "$(pyenv init -)"

ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH
RUN pyenv install 3.11.8 && pyenv global 3.11.8 && pyenv rehash

RUN pip install poetry
