# frozen_string_literal: true

require 'dry/monads'
require 'system/import'

module DryRobot
  module Environment
    module Commands
      module ValidatePosition
        class Transaction
          include Dry::Monads[:result]
          include Import['environment.model']

          def call(x_point:, y_point:)
            if model.valid_position?(x_point: x_point, y_point: y_point)
              Success({ x_point: x_point, y_point: y_point })
            else
              Failure({ x_point: x_point, y_point: y_point })
            end
          end
        end
      end
    end
  end
end
