#!/usr/bin/env ruby
# frozen_string_literal: true

$stdout.sync = true

require 'pry-byebug'
require './lib/system/app_container'
require './lib/dry_robot/app'
AppContainer.finalize!

DryRobot::App.start
