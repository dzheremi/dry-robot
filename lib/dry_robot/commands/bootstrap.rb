# frozen_string_literal: true

require_relative 'adapter'
require_relative 'validator'

AppContainer.namespace('commands') do
  register('adapter', -> { DryRobot::Commands::Adapter.new })
  register('validator', -> { DryRobot::Commands::Validator.new })
end
