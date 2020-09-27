# frozen_string_literal: true

require 'spec_helper'
require 'dry_robot/commands/validator'
require 'dry_robot/commands/request_contract'

RSpec.describe DryRobot::Commands::Validator do
  subject(:validator) { described_class.new }

  let(:request_contract) { instance_double(DryRobot::Commands::RequestContract) }
  let(:successful_validation) { instance_double(Dry::Validation::Result, to_monad: Dry::Monads.Success(:success)) }
  let(:failed_validation) { instance_double(Dry::Validation::Result, to_monad: Dry::Monads.Failure(:failure)) }

  before do
    allow(DryRobot::Commands::RequestContract).to receive(:new).and_return(request_contract)
    allow(request_contract).to receive(:call).and_return(result)
  end

  context 'with valid input' do
    let(:input) { 'PLACE 1,1,N' }
    let(:result) { successful_validation }

    before { validator.call(command: input) }

    it 'initializes a new request contract' do
      expect(DryRobot::Commands::RequestContract).to have_received(:new)
    end

    it 'calls the request contract with the validation input' do
      expect(request_contract).to have_received(:call).with(command: input)
    end

    it 'returns a success' do
      expect(validator.call(command: input)).to be_success
    end
  end

  context 'with invalid input' do
    let(:input) { 'DANCE 1,1,N' }
    let(:result) { failed_validation }

    before { validator.call(command: input) }

    it 'initializes a new request contract' do
      expect(DryRobot::Commands::RequestContract).to have_received(:new)
    end

    it 'calls the request contract with the validation input' do
      expect(request_contract).to have_received(:call).with(command: input)
    end

    it 'returns a failure' do
      expect(validator.call(command: input)).to be_failure
    end
  end
end
