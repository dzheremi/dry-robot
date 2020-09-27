# frozen_string_literal: true

require 'dry/monads'
require 'system/import'

module DryRobot
  module Commands
    class Adapter
      include Dry::Monads[:result]
      include Import[
        command_validator: 'commands.validator',
        robot_left_command: 'robot.commands.left',
        robot_right_command: 'robot.commands.right',
        robot_move_command: 'robot.commands.move',
        robot_report_command: 'robot.commands.report',
        robot_place_contract: 'robot.commands.place.contract',
        robot_place_transaction: 'robot.commands.place.transaction',
      ]

      def call(command:) # rubocop:disable Metrics/MethodLength
        command_validator.call(command: command).bind do |valid_command|
          case valid_command[0]
          when 'LEFT'
            robot_left_command.call
          when 'RIGHT'
            robot_right_command.call
          when 'MOVE'
            robot_move_command.call
          when 'REPORT'
            robot_report_command.call
          when 'PLACE'
            robot_place_contract.call(parse_location(valid_command[1])).bind do |location|
              robot_place_transaction.call(location)
            end
          end
        end
      end

      private

      def parse_location(string)
        location_segments = string.split(',')
        {
          x_point: location_segments[0].to_i,
          y_point: location_segments[1].to_i,
          heading: location_segments[2],
        }
      end
    end
  end
end
