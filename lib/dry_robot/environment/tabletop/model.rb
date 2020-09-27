# frozen_string_literal: true

module DryRobot
  module Environment
    module Tabletop
      class Model
        GRID_WIDTH = 5
        GRID_HIGHT = 5

        def valid_position?(x_point:, y_point:)
          (0...GRID_WIDTH).include?(x_point) && (0...GRID_HIGHT).include?(y_point)
        end
      end
    end
  end
end
