require 'dry/monads'
require 'system/import'
require_relative '../../support/cardinal_direction'

module DryRobot
  module Robot
    module Commands
      module Left
        class Transaction
          include Dry::Monads[:result]
          include Import[robot: 'robot.model']

          def call
            return Failure() unless robot.movement_possible?

            robot.place(
              x_point: robot.x_point,
              y_point: robot.y_point,
              heading: Support::CardinalDirection.rotate(
                heading: robot.heading, rotation: :counter_clockwise
              )
            )

            Success()
          rescue DryRobot::Robot::Model::PositionError
            Failure()
          end
        end
      end
    end
  end
end
