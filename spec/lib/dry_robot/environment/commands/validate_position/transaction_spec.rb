require 'spec_helper'
require 'dry_robot/environment/commands/validate_position/transaction'
require 'dry_robot/environment/tabletop/model'

RSpec.describe DryRobot::Environment::Commands::ValidatePosition::Transaction do
  subject(:transaction) { described_class.new }

  let(:input) { { x_point: 3, y_point: 4 } }
  let(:model) { instance_double(DryRobot::Environment::Tabletop::Model) }

  before do
    AppContainer.stub('environment.model', model)
    allow(DryRobot::Environment::Tabletop::Model).to receive(:new).and_return(model)
  end

  after do
    AppContainer.unstub('environment.model')
  end

  context 'when position is valid' do
    before do
      allow(model).to receive(:valid_position?).with(input).and_return(true)
      transaction.call(**input)
    end

    it 'initializes delegates position validation to the model' do
      expect(model).to have_received(:valid_position?).with(input)
    end

    it 'returns a success' do
      expect(transaction.call(**input)).to be_success
    end
  end

  context 'when position is invalid' do
    before do
      allow(model).to receive(:valid_position?).with(input).and_return(false)
      transaction.call(**input)
    end

    it 'initializes delegates position validation to the model' do
      expect(model).to have_received(:valid_position?).with(input)
    end

    it 'returns a failure' do
      expect(transaction.call(**input)).to be_failure
    end
  end
end
