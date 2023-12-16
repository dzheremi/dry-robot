require 'spec_helper'
require 'dry_robot/robot/commands/place/request_contract'

RSpec.describe DryRobot::Robot::Commands::Place::RequestContract do
  subject(:contract) { described_class.new.call(input) }

  context 'with valid input' do
    let(:input) { '4,3,N' }

    it 'has no errors' do
      expect(contract.errors).to be_empty
    end
  end

  context 'with invalid input' do
    context 'with non-string input' do
      let(:input) { { key: 'hash' } }

      it 'returns errors' do
        expect(contract.errors).not_to be_empty
        expect(contract.errors[:heading]).to be_truthy
        expect(contract.errors[:x_point]).to be_truthy
        expect(contract.errors[:y_point]).to be_truthy
      end
    end

    context 'with invalid compase heading' do
      let(:input) { '4,3,NW' }

      it 'returns errors' do
        expect(contract.errors).not_to be_empty
        expect(contract.errors[:heading]).to be_truthy
      end
    end

    context 'with invalid x coordinate' do
      let(:input) { 'Z,3,N' }

      it 'returns errors' do
        expect(contract.errors).not_to be_empty
        expect(contract.errors[:heading]).to be_truthy
        expect(contract.errors[:x_point]).to be_truthy
        expect(contract.errors[:y_point]).to be_truthy
      end
    end

    context 'with invalid y coordinate' do
      let(:input) { '4,Z,N' }

      it 'returns errors' do
        expect(contract.errors).not_to be_empty
        expect(contract.errors[:heading]).to be_truthy
        expect(contract.errors[:x_point]).to be_truthy
        expect(contract.errors[:y_point]).to be_truthy
      end
    end
  end
end
