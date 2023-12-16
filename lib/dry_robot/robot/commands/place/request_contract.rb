require 'dry-validation'
require_relative '../../types'

Dry::Validation.load_extensions(:monads)

module DryRobot
  module Robot
    module Commands
      module Place
        class RequestContract < Dry::Validation::Contract
          params do
            required(:x_point).filled(Types::Strict::Integer)
            required(:y_point).filled(Types::Strict::Integer)
            required(:heading).filled(Types::CompassPoints)
          end

          def call(command_input)
            super(parse_location(command_input))
          end

          private

          def parse_location(string)
            location_segments = string.split(',')

            {
              x_point: Integer(location_segments[0]),
              y_point: Integer(location_segments[1]),
              heading: location_segments[2]
            }
          rescue StandardError
            nil
          end
        end
      end
    end
  end
end
