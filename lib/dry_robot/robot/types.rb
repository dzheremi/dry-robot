require 'dry-types'

module DryRobot
  module Robot
    module Types
      include Dry.Types()

      ROTATIONS = %i[clockwise counter_clockwise].freeze

      # Points must be defined in this array in a clockwise order starting from NORTH.
      COMPASS_POINTS = %w[N E S W].freeze

      CompassPoints = Types::Strict::String.enum(*COMPASS_POINTS)
    end
  end
end
