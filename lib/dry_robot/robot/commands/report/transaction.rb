require 'dry/monads'
require 'system/import'

module DryRobot
  module Robot
    module Commands
      module Report
        class Transaction
          include Dry::Monads[:result]
          include Import[robot: 'robot.model']

          def call
            Success(robot.report)
          end
        end
      end
    end
  end
end
