# frozen_string_literal: true

require_relative './commands/validate_position/request_contract'
require_relative './commands/validate_position/transaction'
require_relative './tabletop/model'

AppContainer.namespace('environment') do
  register('contract', -> { DryRobot::Environment::Commands::ValidatePosition::RequestContract.new })
  register('transaction', -> { DryRobot::Environment::Commands::ValidatePosition::Transaction.new })
  register('model', -> { DryRobot::Environment::Tabletop::Model.new })
end
