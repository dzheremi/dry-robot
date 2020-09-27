# frozen_string_literal: true

require_relative 'bootstrap'

module DryRobot
  module App
    def self.start
      puts 'This does something useful!'
      binding.pry
    end
  end
end
