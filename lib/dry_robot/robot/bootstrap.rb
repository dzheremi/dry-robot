# frozen_string_literal: true

require_relative 'model'

AppContainer.namespace('robot') do
  register('model', -> { DryRobot::Robot::Model.new })
end
