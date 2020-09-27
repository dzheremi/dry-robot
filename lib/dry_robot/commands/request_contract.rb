# frozen_string_literal: true

require 'dry-validation'
require_relative 'types'

Dry::Validation.load_extensions(:monads)

module DryRobot
  module Commands
    class RequestContract < Dry::Validation::Contract
      params do
        required(:command).filled(Types::Command)
      end
    end
  end
end
