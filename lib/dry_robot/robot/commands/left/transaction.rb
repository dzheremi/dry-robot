require 'dry/monads'
require 'system/import'

module DryRobot
  module Robot
    module Commands
      module Left
        class Transaction
          include Dry::Monads[:result]
          include Import[robot: 'robot.model']

          def call
            robot.turn_left
            Success(robot.report)
          rescue DryRobot::Robot::Model::MovementNotPossibleError
            Failure()
          end
        end
      end
    end
  end
end
