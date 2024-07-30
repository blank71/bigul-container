FROM registry.fedoraproject.org/fedora

# install packages
RUN dnf update -y 
RUN dnf groupinstall -y "Minimal Install" "Development Tools"
RUN dnf install -y gcc gcc-c++ gmp gmp-devel make ncurses ncurses-compat-libs ncurses-static xz perl pkg-config
RUN curl -sSL https://get.haskellstack.org/ | sh
RUN echo 'export PATH="/root/.local/bin:$PATH"' >> "/root/.bash_profile"
RUN dnf clean all
RUN rm -rf /var/cache/yum

# stack configuration
RUN mkdir -p /root/.stack/global-project/ && \
git clone https://bitbucket.org/prl_tokyo/BiGUL.git /root/.stack/global-project/BiGUL && \
cat <<'_EOF_' > /root/.stack/global-project/stack.yaml 
packages: [BiGUL/Haskell]
# resolver: ghc-8.0.2
resolver: 
    url: https://raw.githubusercontent.com/commercialhaskell/stackage-snapshots/master/lts/12/26.yaml
# snapshot: lts-22.31

extra-deps:
_EOF_
RUN stack install --verbose BiGUL

WORKDIR /root/

# clone BiGUL
# RUN git clone https://bitbucket.org/prl_tokyo/BiGUL.git

CMD [ "/bin/bash" ]