# frozen_string_literal: true

require_relative 'validator'

AppContainer.namespace('commands') do
  register('validator', -> { DryRobot::Commands::Validator.new })
end
