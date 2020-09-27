# frozen_string_literal: true

require_relative 'request_contract'

module DryRobot
  module Commands
    class Validator
      def call(command:)
        RequestContract.new.call(command).to_monad
      end
    end
  end
end
