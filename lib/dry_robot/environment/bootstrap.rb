# frozen_string_literal: true

require_relative './tabletop/model'

AppContainer.namespace('environment') do
  register('model', -> { DryRobot::Environment::Tabletop::Model.new })
end
