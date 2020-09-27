# frozen_string_literal: true

require 'dry/monads'
require 'system/import'

module DryRobot
  module Robot
    module Commands
      module Right
        class Transaction
          include Dry::Monads[:result]
          include Import[robot: 'robot.model']

          def call
            robot.turn_right
            Success(robot.report)
          rescue DryRobot::Robot::Model::MovementNotPossibleError
            Failure()
          end
        end
      end
    end
  end
end
