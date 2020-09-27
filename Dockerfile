FROM ruby:2.7.1-slim-buster

ENV RUBY_BUNDLER_VERSION '2.1.4'

RUN apt-get update \
  && apt-get install -y --no-install-recommends build-essential \
  && rm -fr /var/libs/apt/lists/*

COPY . .

RUN gem install bundler -v ${RUBY_BUNDLER_VERSION}
RUN bundle install

CMD ./start.rb
