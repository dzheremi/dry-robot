# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'
require 'system/import'

module DryRobot
  module Robot
    module Commands
      module Place
        class Transaction
          include Dry::Monads[:result]
          include Dry::Monads::Do.for(:call)
          include Import[
            valid_environment_position: 'environment.transaction',
            robot: 'robot.model'
          ]

          def call(x_point:, y_point:, heading:)
            valid_position = yield valid_environment_position.call(x_point: x_point, y_point: y_point)
            robot.place(
              x_point: valid_position[:x_point],
              y_point: valid_position[:y_point],
              heading: heading,
            )
            Success(robot)
          rescue DryRobot::Robot::Model::PositionError
            Failure()
          end
        end
      end
    end
  end
end
