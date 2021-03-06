FROM ubuntu:14.04

## install build deps
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    wget \
    git \
    build-essential \
    libssl-dev \
    libreadline-dev \
    zlib1g-dev \
    software-properties-common \
    apt-transport-https \
    libfontconfig

## install grafana
RUN wget https://grafanarel.s3.amazonaws.com/builds/grafana_4.1.2-1486989747_amd64.deb \
  && dpkg -i grafana_4.1.2-1486989747_amd64.deb

## install rbenv
RUN cd /tmp \
  && git clone https://github.com/rbenv/rbenv.git /usr/local/rbenv \
  && cd /usr/local/rbenv \
  && src/configure \
  && make -C src

## install ruby-build
RUN cd /tmp \
  && git clone https://github.com/rbenv/ruby-build.git /usr/local/rbenv/plugins/ruby-build

## setup rbenv env
RUN echo '# rbenv setup' > /etc/profile.d/rbenv.sh \
  && echo 'export RBENV_ROOT=/usr/local/rbenv' >> /etc/profile.d/rbenv.sh \
  && echo 'export PATH="$RBENV_ROOT/bin:$PATH"' >> /etc/profile.d/rbenv.sh \
  && echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh

## install ruby versions
RUN . /etc/profile.d/rbenv.sh \
  && rbenv install 2.2.5 \
  && rbenv global 2.2.5

RUN . /etc/profile.d/rbenv.sh \
  && gem install mustache

## setup startup files
ADD ./files/setup.rb /setup.rb
ADD ./files/startup.sh /startup.sh

## set startup files permissions
RUN chmod +x /startup.sh

CMD /startup.sh
