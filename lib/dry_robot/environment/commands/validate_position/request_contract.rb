# frozen_string_literal: true

require 'dry-validation'
require_relative '../../types'

Dry::Validation.load_extensions(:monads)

module DryRobot
  module Environment
    module Commands
      module ValidatePosition
        class RequestContract < Dry::Validation::Contract
          params do
            required(:x_point).filled(Types::Strict::Integer, gt?: 0)
            required(:y_point).filled(Types::Strict::Integer, gt?: 0)
          end
        end
      end
    end
  end
end
