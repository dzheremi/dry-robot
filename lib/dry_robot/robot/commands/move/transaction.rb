# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'
require 'system/import'

module DryRobot
  module Robot
    module Commands
      module Move
        class Transaction
          include Dry::Monads[:result]
          include Dry::Monads::Do.for(:call)
          include Import[
            valid_environment_position: 'environment.transaction',
            robot: 'robot.model'
          ]

          def call
            yield valid_environment_position.call(**robot.next_movement)
            robot.move
            Success(robot.report)
          rescue DryRobot::Robot::Model::MovementNotPossibleError
            Failure()
          end
        end
      end
    end
  end
end
