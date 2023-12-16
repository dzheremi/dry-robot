require 'spec_helper'
require 'dry_robot/robot/commands/contract_factory'

RSpec.describe DryRobot::Robot::Commands::ContractFactory do
  subject(:contract_factory) { described_class.new }

  describe 'fetch' do
    context 'with the place contract identifier' do
      it 'returns the request contract' do
        contract = contract_factory.fetch(contract_identifier: 'place')
        expect(contract).to be_a(DryRobot::Robot::Commands::Place::RequestContract)
      end
    end

    context 'with an invalid identifier' do
      it 'returns nil' do
        contract = contract_factory.fetch(contract_identifier: 'salami')
        expect(contract).to be_nil
      end
    end
  end
end
