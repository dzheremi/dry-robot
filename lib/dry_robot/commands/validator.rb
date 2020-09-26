# frozen_string_literal: true

require 'dry-monads'

module DryRobot
  module Commands
    class Validator
      include Dry::Monads[:result]
      include Dry::Monads::Do.for(:call)

      def call(command:); end
    end
  end
end
