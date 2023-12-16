require_relative 'left/transaction'
require_relative 'move/transaction'
require_relative 'place/transaction'
require_relative 'report/transaction'
require_relative 'right/transaction'

module DryRobot
  module Robot
    module Commands
      class CommandFactory
        AVAILABLE_COMMANDS = {
          'left' => Left::Transaction,
          'move' => Move::Transaction,
          'place' => Place::Transaction,
          'report' => Report::Transaction,
          'right' => Right::Transaction
        }.freeze

        def fetch(command_identifier:)
          AVAILABLE_COMMANDS.fetch(command_identifier).new
        rescue KeyError
          nil
        end
      end
    end
  end
end
