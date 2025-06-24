FROM registry.fedoraproject.org/fedora:42@sha256:49d8eb9a2abb87574ea1da87c7b28cd9fb490d5c3e11b5b45fbb5d0bd494077b

# install packages
RUN dnf update -y && \
dnf group install -y "development-tools" && \
dnf install -y gcc gcc-c++ gmp gmp-devel make ncurses ncurses-compat-libs ncurses-static xz perl pkg-config && \
curl -sSL https://get.haskellstack.org/ | sh && \
echo 'export PATH="/root/.local/bin:$PATH"' >> "/root/.bash_profile" && \
dnf clean all && \
rm -rf /var/cache/yum

# stack configuration
RUN mkdir -p /root/.stack/global-project/ && \
git clone https://bitbucket.org/prl_tokyo/BiGUL.git /root/.stack/global-project/BiGUL && \
cat <<'_EOF_' > /root/.stack/global-project/stack.yaml 
packages: [BiGUL/Haskell]
resolver: 
    url: https://raw.githubusercontent.com/commercialhaskell/stackage-snapshots/master/lts/12/26.yaml
extra-deps:
_EOF_
RUN stack install --verbose BiGUL

WORKDIR /root/

# clone BiGUL
# RUN git clone https://bitbucket.org/prl_tokyo/BiGUL.git

CMD [ "/bin/bash" ]
