require 'dry/monads'
require 'system/import'

module DryRobot
  module Commands
    class Adapter
      include Dry::Monads[:result]
      include Import[
        command_validator: 'commands.validator',
        command_factory: 'robot.command_factory',
        contract_factory: 'robot.contract_factory'
      ]

      def call(command:) # rubocop:disable Metrics/AbcSize
        command_validator.call(command:).bind do |valid_command|
          command_identifier = valid_command[:command][0].downcase
          command = command_factory.fetch(command_identifier:)
          return Failure() unless command

          contract = contract_factory.fetch(contract_identifier: command_identifier)
          return command.call unless contract

          contract.call(valid_command[:command][1]).to_monad.bind do |valid_contract|
            command.call(**valid_contract.to_h)
          end
        end
      end
    end
  end
end
