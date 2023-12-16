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
        end
      end
    end
  end
end
