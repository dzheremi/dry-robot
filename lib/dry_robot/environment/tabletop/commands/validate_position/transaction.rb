# frozen_string_literal: true

require 'dry/monads'
require_relative '../../model'

module DryRobot
  module Environment
    module Tabletop
      module Commands
        module ValidatePosition
          class Transaction
            include Dry::Monads[:result]

            def call(x_point:, y_point:)
              if Model.new.valid_position?(x_point: x_point, y_point: y_point)
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
end
