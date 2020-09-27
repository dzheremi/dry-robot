# frozen_string_literal: true

require 'dry-types'
require 'dry/monads'

module DryRobot
  module Commands
    module Types
      include Dry.Types()

      Command = Types.Constructor(Types::Strict::Array) do |value|
        CommandParser.parse(value)
      end

      POSITION_COMMANDS = %w[PLACE].freeze
      SINGLE_COMMANDS = %w[MOVE LEFT RIGHT REPORT].freeze

      PositionCommandArguments = Types::Strict::String.enum(*POSITION_COMMANDS)
      SingleCommandArguments = Types::Strict::String.enum(*SINGLE_COMMANDS)
      PositionArgument = Strict::String.constrained(
        format: /^[1-5]{1},[1-5]{1},[NSEW]{1}$/,
      )

      class CommandParser
        include Dry::Monads[:result]

        def self.parse(input)
          result = new.call(input)
          result.value! unless result.failure?
        end

        def call(input)
          arguments_from_string(input).bind do |arguments|
            parse_single_command(arguments).bind { |command| return Success(command) }
            parse_position_command(arguments).bind { |command| return Success(command) }
          end

          Failure(input)
        end

        private

        def arguments_from_string(string)
          arguments = string.split(' ')
          if arguments.size <= 2
            Success(arguments)
          else
            Failure(string)
          end
        end

        def parse_single_command(arguments)
          return Failure(arguments) if arguments.size > 1

          Success([SingleCommandArguments[arguments[0]]])
        rescue Dry::Types::ConstraintError
          Failure(arguments[0])
        end

        def parse_position_command(arguments)
          return Failure(arguments) unless arguments.size == 2

          Success(
            [
              PositionCommandArguments[arguments[0]],
              PositionArgument[arguments[1]],
            ],
          )
        rescue Dry::Types::ConstraintError
          Failure(arguments[0])
        end
      end
    end
  end
end
