FROM obolibrary/odkfull
# https://hub.docker.com/r/bopen/ubuntu-pyenv is based on ubuntu image

ENV LANG="C.UTF-8" \
    LC_ALL="C.UTF-8" \
    PATH="/root/.pyenv/shims:/root/.pyenv/bin:$PATH" \
    PYENV_ROOT="/root/.pyenv" \
    PYENV_SHELL="bash" \
    AML_VERSION="3.2" \
    LOGMAP_VERSION="4.0"

### Download matchers
COPY image.Makefile Makefile
ENV AML_ZIP "https://github.com/AgreementMakerLight/AML-Project/releases/download/v$(AML_VERSION)/AML_v$(AML_VERSION).zip"
RUN make dependencies && make clean && rm Makefile

#### Install PyEnv
# Instructions from https://code.luasoftware.com/tutorials/linux/install-latest-python-on-ubuntu-via-pyenv/
RUN git clone --depth 1 https://github.com/pyenv/pyenv.git $PYENV_ROOT &&\
    echo 'export PYENV_ROOT="/root/.pyenv/"' >> /root/.bashrc &&\
    echo 'export PATH="/root/.pyenv/bin:$PATH"' >> /root/.bashrc &&\
    echo 'if command -v pyenv 1>/dev/null 2>&1; then\n eval "$(pyenv init -)"\nfi' >> /root/.bashrc &&\
    echo "Pyenv setup done"

COPY requirements.txt /
RUN pip install -r /requirements.txt

# See https://github.com/pyenv/pyenv/wiki/common-build-problems
RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y build-essential libssl-dev zlib1g-dev libbz2-dev \
libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
xz-utils tk-dev libffi-dev liblzma-dev python-openssl git
RUN git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv
RUN echo 'eval "$(pyenv virtualenv-init -)"' >> /root/.bash_profile
RUN pyenv install 3.7.10 && pyenv virtualenv 3.7.10 logmap_ml
RUN pyenv install 2.7.18 && pyenv virtualenv 2.7.18 paxo

COPY config /match_config
RUN cp /match_config/* /tools
 
RUN $PYENV_ROOT/versions/paxo/bin/pip install -r /tools/requirements-paxo.txt
RUN $PYENV_ROOT/versions/logmap_ml/bin/pip install -r /tools/requirements-logmap-ml.txt
RUN python -m pip uninstall sssom && pip install git+https://github.com/mapping-commons/sssom-py.git@sssom-1

