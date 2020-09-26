#!/usr/bin/env ruby
# frozen_string_literal: true

$stdout.sync = true
$LOAD_PATH << File.expand_path('lib', __dir__)

require 'dry_robot/app'

DryRobot::App.start
