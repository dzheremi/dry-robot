# frozen_string_literal: true

require 'dry-validation'
require 'dry-types'

Dry::Validation.load_extensions(:monads)

module DryRobot
  module Environment
    module Commands
      module ValidatePosition
        class RequestContract < Dry::Validation::Contract
          params do
            required(:x_point).filled(Dry::Types['strict.integer'], gt?: 0)
            required(:y_point).filled(Dry::Types['strict.integer'], gt?: 0)
          end
        end
      end
    end
  end
end
