# frozen_string_literal: true

require 'dry-initializer'
require_relative 'types'

module DryRobot
  module Robot
    class Model
      extend Dry::Initializer

      option :x_point, type: Types::Strict::Integer
      option :y_point, type: Types::Strict::Integer
      option :heading, type: Types::CompassPoints

      def turn_right
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
        destination = next_movement
        @x_point = destination[:x_point]
        @y_point = destination[:y_point]
      end

      def next_movement
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
    end
  end
end
