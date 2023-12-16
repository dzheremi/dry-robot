require_relative 'model'
require_relative 'commands/command_factory'
require_relative 'commands/contract_factory'

AppContainer.namespace('robot') do
  register('model', DryRobot::Robot::Model.new)
  register('command_factory', DryRobot::Robot::Commands::CommandFactory.new)
  register('contract_factory', DryRobot::Robot::Commands::ContractFactory.new)
end
