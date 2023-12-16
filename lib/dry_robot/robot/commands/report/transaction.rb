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
            Success(
              robot.movement_possible? ? "#{robot.x_point},#{robot.y_point},#{robot.heading}" : 'No Position'
            )
          end
        end
      end
    end
  end
end
