ARG RUBY_VERSION=3.3.10
FROM docker.io/library/ruby:$RUBY_VERSION-slim AS base

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential git curl libyaml-dev pkg-config && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Throw-away build stage to reduce size of final image
FROM base AS build

WORKDIR /app

RUN gem install bundler

# Install application gems
COPY Gemfile Gemfile.lock ./
RUN bundle config set deployment true
RUN bundle config set without 'development test'
RUN bundle config set path '/bundle'
RUN bundle install

ENV JEKYLL_ENV='docker'

EXPOSE 4000
CMD ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0"]
# "--livereload"