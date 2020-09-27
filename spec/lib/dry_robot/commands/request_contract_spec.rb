# frozen_string_literal: true

require 'spec_helper'
require 'dry_robot/commands/request_contract'

RSpec.describe DryRobot::Commands::RequestContract do
  subject(:contract) { described_class.new.call(input) }

  context 'with valid input' do
    let(:input) { { command: 'PLACE 1,1,N' } }

    it 'has no errors' do
      expect(contract.errors).to be_empty
    end
  end

  context 'with invalid input' do
    context 'with an invalid command' do
      let(:input) { { command: 'ATTACK HUMANS' } }

      it 'returns errors' do
        expect(contract.errors).not_to be_empty
        expect(contract.errors[:command]).to be_truthy
      end
    end

    context 'with no command supplied' do
      let(:input) { { command: nil } }

      it 'returns errors' do
        expect(contract.errors).not_to be_empty
        expect(contract.errors[:command]).to be_truthy
      end
    end
  end
end
