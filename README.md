# Dry Robot
### Coding Challenge

## Introduction
This is an implementation of the Robot Challenge written in Ruby 2.7.1 utilising many of the libraries from [dry-rb](https://dry-rb.org/), including:
  * dry-initializer
  * dry-monads
  * dry-system
  * dry-types
  * dry-validation

Hope you enjoy!

## Running Locally

**To install the required bundler version:**
```bash
$ gem install bundler -v 2.1.4
```

**To install the required Gems:**
```bash
$ bundle install
```

**To run the test suite:**
```bash
$ bundle exec rspec -fd
```

**To run the application:**
```bash
$ bundle exec ./start.rb
```

## Running via Docker

**To build the Docker image:**
```bash
$ docker build -t dryrobot .
```

**To run the application:**
```bash
$ docker run -it dryrobot
```

## Development

**To run the linting tool:**
```bash
$ bundle exec rubocop
```

**To launch an interactive console:**
```bash
$ ./scripts/console
```
