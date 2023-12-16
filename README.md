# Dry Robot

### Coding Challenge

## Changelog

- Bumped Ruby to 3.2.2 and updated all dependencies to latest, fixing breaking changes with `Dry::System::Container`
- Refactored `DryRobot::Robot::Model` moving all behaviour to various `DryRobot::Robot::Commands`
- Introduced `DryRobot::Robot::Commands::CommandFactory`
- Introduced `DryRobot::Robot::Commands::ContractFactory`
- Removed individual robot commands from the DI system, replacing with factories.
- Refactored `DryRobot::Commands::Adapter` to use the two new factories.

A complete list of changes can be seen [here](https://github.com/dzheremi/dry-robot/pull/1/).

#### Outstanding:

I would like to refactor the way positions are represented in this model as it has become quite cumbersome and restricts potential changes moving forward, and I would like to abstract the interface further away from the core domain.

## Introduction

This is an implementation of the Robot Challenge written in Ruby 3.2.2 utilising many of the libraries from [dry-rb](https://dry-rb.org/), including:

- dry-initializer
- dry-monads
- dry-system
- dry-types
- dry-validation

Hope you enjoy!

## Running Locally

**To install the required bundler version:**

```bash
$ gem install bundler -v 2.4.10
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
