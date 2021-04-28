FROM obolibrary/odkfull
# https://hub.docker.com/r/bopen/ubuntu-pyenv is based on ubuntu image

COPY image.Makefile Makefile
COPY config /match_config
RUN cp /match_config/* /tools
ENV AML_VERSION 3.2
ENV AML_ZIP "https://github.com/AgreementMakerLight/AML-Project/releases/download/v$(AML_VERSION)/AML_v$(AML_VERSION).zip"
ENV LOGMAP_VERSION 4.0
RUN make dependencies
RUN apt update -y && git clone https://github.com/pyenv/pyenv.git ~/.pyenv
ENV LANG="C.UTF-8" \
    LC_ALL="C.UTF-8" \
    PATH="/opt/pyenv/shims:/opt/pyenv/bin:$PATH" \
    PYENV_ROOT="/opt/pyenv" \
    PYENV_SHELL="bash"

RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        ca-certificates \
        curl \
        git \
        libbz2-dev \
        libffi-dev \
        libncurses5-dev \
        libncursesw5-dev \
        libreadline-dev \
        libsqlite3-dev \
        libssl1.0-dev \
        liblzma-dev \
        # libssl-dev \
        llvm \
        make \
        netbase \
        pkg-config \
        tk-dev \
        wget \
        xz-utils \
        zlib1g-dev \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY pyenv-version.txt python-versions.txt /

RUN git clone -b `cat /pyenv-version.txt` --single-branch --depth 1 https://github.com/pyenv/pyenv.git $PYENV_ROOT \
    && for version in `cat /python-versions.txt`; do pyenv install $version; done \
    && pyenv global `cat /python-versions.txt` \
    && find $PYENV_ROOT/versions -type d '(' -name '__pycache__' -o -name 'test' -o -name 'tests' ')' -exec rm -rf '{}' + \
    && find $PYENV_ROOT/versions -type f '(' -name '*.pyo' -o -name '*.exe' ')' -exec rm -f '{}' + \
 && rm -rf /tmp/*

COPY requirements-setup.txt requirements-test.txt requirements-ci.txt /
RUN pip install -r /requirements-setup.txt \
    && pip install -r /requirements-test.txt \
    && pip install -r /requirements-ci.txt \
    && find $PYENV_ROOT/versions -type d '(' -name '__pycache__' -o -name 'test' -o -name 'tests' ')' -exec rm -rf '{}' + \
    && find $PYENV_ROOT/versions -type f '(' -name '*.pyo' -o -name '*.exe' ')' -exec rm -f '{}' + \
 && rm -rf /tmp/*
 
RUN pyenv virtualenv 3.7 paxo
