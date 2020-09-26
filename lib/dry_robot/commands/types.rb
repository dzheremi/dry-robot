# frozen_string_literal: true

require 'dry-types'
require 'dry-monads'

module DryRobot
  module Commands
    module Types
      include Dry.Types()

      BASE_COMMANDS = %w[PLACE MOVE LEFT RIGHT REPORT].freeze

      Command = Types.Constructor(Types::Strict::String) do |value|
        CommandParser.parse(value)
      end

      BaseCommandArguments = Types::Strict::String.enum(*BASE_COMMANDS)
      PositionArgument = Strict::String.constrained(
        format: /^[1-5]{1},[1-5]{1},[NSEW]{1}$/,
      )

      class CommandParser
        include Dry::Monads[:result]

        def self.parse(input)
          result = new.call(input)
          result.value! unless result.failure?
        end

        def call(input); end
      end
    end
  end
end
