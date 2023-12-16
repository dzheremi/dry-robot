FROM ruby:3.2.2-slim-bullseye

ENV RUBY_BUNDLER_VERSION '2.4.10'

RUN apt-get update \
  && apt-get install -y --no-install-recommends build-essential \
  && rm -fr /var/libs/apt/lists/*

COPY . .

RUN gem install bundler -v ${RUBY_BUNDLER_VERSION}
RUN bundle install

CMD ./start.rb
