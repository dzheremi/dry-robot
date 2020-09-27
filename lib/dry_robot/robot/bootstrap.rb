# frozen_string_literal: true

require_relative 'model'
require_relative './commands/left/transaction'
require_relative './commands/right/transaction'
require_relative './commands/move/transaction'
require_relative './commands/place/transaction'
require_relative './commands/place/request_contract'
require_relative './commands/report/transaction'

AppContainer.namespace('robot') do
  register('model', DryRobot::Robot::Model.new)
  namespace('commands') do
    register('left', -> { DryRobot::Robot::Commands::Left::Transaction.new })
    register('right', -> { DryRobot::Robot::Commands::Right::Transaction.new })
    register('move', -> { DryRobot::Robot::Commands::Move::Transaction.new })
    register('report', -> { DryRobot::Robot::Commands::Report::Transaction.new })
    namespace('place') do
      register('transaction', -> { DryRobot::Robot::Commands::Place::Transaction.new })
      register('contract', -> { DryRobot::Robot::Commands::Place::RequestContract.new })
    end
  end
end
