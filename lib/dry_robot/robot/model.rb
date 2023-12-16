require 'dry-initializer'
require_relative 'types'

module DryRobot
  module Robot
    class Model
      class PositionError < StandardError; end

      extend Dry::Initializer

      attr_reader :x_point, :y_point, :heading

      option :x_point, type: Types::Strict::Integer, optional: true
      option :y_point, type: Types::Strict::Integer, optional: true
      option :heading, type: Types::CompassPoints, optional: true

      def place(x_point:, y_point:, heading:)
        @x_point = Types::Strict::Integer[x_point]
        @y_point = Types::Strict::Integer[y_point]
        @heading = Types::CompassPoints[heading]
      rescue Dry::Types::ConstraintError
        raise PositionError
      end

      def movement_possible?
        @x_point != Dry::Initializer::UNDEFINED ||
          @y_point != Dry::Initializer::UNDEFINED ||
          @heading != Dry::Initializer::UNDEFINED
      end
    end
  end
end
