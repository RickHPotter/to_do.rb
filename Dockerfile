ARG RUBY_VERSION=3.3.0-bullseye
FROM ruby:$RUBY_VERSION

RUN apt-get update -qq && \
  apt-get install -y \
  build-essential \
  git \
  libvips \
  bash \
  bash-completion \
  libffi-dev \
  tzdata \
  postgresql \
  nodejs \
  npm \
  yarn && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /usr/share/doc /usr/share/man

RUN apt-get install wget && wget -q https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz && \
  tar -xf nvim-linux64.tar.gz && mv nvim-linux64 nvim && \
  printf "export PATH=/nvim/bin:\$PATH" >> ~/.bashrc

WORKDIR /rails
COPY . /rails/

ENV BUNDLE_PATH /gems
RUN bundle && EDITOR=nvim bin/rails credentials:edit && \
  RAILS_SECRET_KEY_BASE_DUMMY=1 bin/rails assets:clean assets:precompile

ENTRYPOINT ["bin/docker-entrypoint"]
