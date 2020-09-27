# frozen_string_literal: true

require 'spec_helper'
require 'dry_robot/environment/tabletop/commands/validate_position/request_contract'

RSpec.describe DryRobot::Environment::Tabletop::Commands::ValidatePosition::RequestContract do
  subject(:contract) { described_class.new.call(input) }

  context 'with valid input' do
    let(:input) { { x_point: 4, y_point: 3 } }

    it 'has no errors' do
      expect(contract.errors).to be_empty
    end
  end

  context 'with invalid input' do
    context 'with negative input' do
      let(:input) { { x_point: -1, y_point: 3 } }

      it 'returns errors' do
        expect(contract.errors).not_to be_empty
        expect(contract.errors[:x_point]).to be_truthy
      end
    end

    context 'with decimal input' do
      let(:input) { { x_point: 4.33, y_point: 3 } }

      it 'returns errors' do
        expect(contract.errors).not_to be_empty
        expect(contract.errors[:x_point]).to be_truthy
      end
    end

    context 'with string input' do
      let(:input) { { x_point: '3', y_point: 3 } }

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
  end
end
