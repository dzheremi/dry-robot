#!/usr/bin/env ruby
# frozen_string_literal: true

$stdout.sync = true
$LOAD_PATH << File.expand_path('lib', __dir__)

require 'system/app_container'
require 'dry_robot/bootstrap'
require 'dry_robot/app'

AppContainer.finalize!

DryRobot::App.start
