# frozen_string_literal: true

require_relative 'bootstrap'

module DryRobot
  module App
    def self.start
      puts 'Issue command to get started, or type EXIT to quit.'
      command = gets.chomp
      while command != 'EXIT'
        puts AppContainer['commands.adapter'].call(command: command)
        command = gets.chomp
      end
    end
  end
end
