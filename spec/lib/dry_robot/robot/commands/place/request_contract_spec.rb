require 'spec_helper'
require 'dry_robot/robot/commands/place/request_contract'

RSpec.describe DryRobot::Robot::Commands::Place::RequestContract do
  subject(:contract) { described_class.new.call(input) }

  context 'with valid input' do
    let(:input) { { x_point: 4, y_point: 3, heading: 'N' } }

    it 'has no errors' do
      expect(contract.errors).to be_empty
    end
  end

  context 'with invalid input' do
    context 'with decimal input' do
      let(:input) { { x_point: 4.33, y_point: 3, heading: 'N' } }

      it 'returns errors' do
        expect(contract.errors).not_to be_empty
        expect(contract.errors[:x_point]).to be_truthy
      end
    end

    context 'with string input' do
      let(:input) { { x_point: '3', y_point: 3, heading: 'N' } }

      it 'returns errors' do
        expect(contract.errors).not_to be_empty
        expect(contract.errors[:x_point]).to be_truthy
      end
    end

    context 'with null input' do
      let(:input) { { x_point: nil, y_point: 3 } }

      it 'returns errors' do
        expect(contract.errors).not_to be_empty
        expect(contract.errors[:x_point]).to be_truthy
      end
    end

    context 'with invalid compass point' do
      let(:input) { { x_point: nil, y_point: 3, heading: 'SSW' } }

      it 'returns errors' do
        expect(contract.errors).not_to be_empty
        expect(contract.errors[:heading]).to be_truthy
      end
    end
  end
end
