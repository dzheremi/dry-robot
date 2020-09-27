# frozen_string_literal: true

require 'dry-initializer'
require_relative 'types'

module DryRobot
  module Robot
    class Model
      class PositionError < StandardError; end
      class MovementNotPossibleError < StandardError; end

      extend Dry::Initializer

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

      def turn_right
        raise MovementNotPossibleError unless movement_possible?

        case @heading
        when 'N'
          @heading = 'E'
        when 'E'
          @heading = 'S'
        when 'S'
          @heading = 'W'
        when 'W'
          @heading = 'N'
        end
      end

      def turn_left
        raise MovementNotPossibleError unless movement_possible?

        case @heading
        when 'N'
          @heading = 'W'
        when 'W'
          @heading = 'S'
        when 'S'
          @heading = 'E'
        when 'E'
          @heading = 'N'
        end
      end

      def move
        raise MovementNotPossibleError unless movement_possible?

        destination = next_movement
        @x_point = destination[:x_point]
        @y_point = destination[:y_point]
      end

      def next_movement
        raise MovementNotPossibleError unless movement_possible?

        case @heading
        when 'N'
          { x_point: @x_point + 1, y_point: @y_point }
        when 'S'
          { x_point: @x_point - 1, y_point: @y_point }
        when 'E'
          { x_point: @x_point, y_point: @y_point + 1 }
        when 'W'
          { x_point: @x_point, y_point: @y_point - 1 }
        end
      end

      private

      def movement_possible?
        @x_point != Dry::Initializer::UNDEFINED ||
          @y_point != Dry::Initializer::UNDEFINED ||
          @heading != Dry::Initializer::UNDEFINED
      end
    end
  end
end
