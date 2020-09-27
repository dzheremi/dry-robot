# frozen_string_literal: true

require 'dry-types'

module DryRobot
  module Robot
    module Types
      include Dry.Types()

      COMPASS_POINTS = %w[N S E W].freeze

      CompassPoints = Types::Strict::String.enum(*COMPASS_POINTS)
    end
  end
end
