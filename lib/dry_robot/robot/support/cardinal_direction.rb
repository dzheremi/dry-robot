require_relative '../types'

module DryRobot
  module Robot
    module Support
      module CardinalDirection
        class InvalidHeadingError < StandardError; end
        class InvalidRotationError < StandardError; end

        class << self
          def rotate(heading:, rotation: :clockwise)
            raise InvalidHeadingError unless Types::COMPASS_POINTS.include? heading
            raise InvalidRotationError unless Types::ROTATIONS.include? rotation

            points = Types::COMPASS_POINTS.dup
            points.reverse! unless rotation == :clockwise

            index = points.find_index heading
            return points[0] if index == points.length - 1

            points[index + 1]
          end
        end
      end
    end
  end
end
