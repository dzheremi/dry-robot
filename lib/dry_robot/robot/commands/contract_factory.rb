require_relative 'place/request_contract'

module DryRobot
  module Robot
    module Commands
      class ContractFactory
        AVAILABLE_CONTRACTS = {
          'place' => Place::RequestContract
        }.freeze

        def fetch(contract_identifier:)
          AVAILABLE_CONTRACTS.fetch(contract_identifier).new
        rescue KeyError
          nil
        end
      end
    end
  end
end
