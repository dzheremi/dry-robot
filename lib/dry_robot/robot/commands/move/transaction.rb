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

          def call # rubocop:disable Metrics/AbcSize
            return Failure() unless robot.movement_possible?

            next_position = next_movement(
              x_point: robot.x_point,
              y_point: robot.y_point,
              heading: robot.heading
            )
            yield valid_environment_position.call(**next_position)
            robot.place(**next_position.merge({ heading: robot.heading }))
            Success()
          end

          private

          def next_movement(x_point:, y_point:, heading:)
            case heading
            when 'N'
              { x_point: x_point + 1, y_point: }
            when 'S'
              { x_point: x_point - 1, y_point: }
            when 'E'
              { x_point:, y_point: y_point + 1 }
            when 'W'
              { x_point:, y_point: y_point - 1 }
            end
          end
        end
      end
    end
  end
end
