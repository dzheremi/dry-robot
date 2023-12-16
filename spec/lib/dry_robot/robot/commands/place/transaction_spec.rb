require 'spec_helper'
require 'dry_robot/robot/commands/place/transaction'
require 'dry_robot/robot/model'
require 'dry_robot/environment/commands/validate_position/transaction'

RSpec.describe DryRobot::Robot::Commands::Place::Transaction do
  subject(:transaction) { described_class.new }

  let(:input) { { x_point: 3, y_point: 4, heading: 'S' } }
  let(:environment_transaction) { instance_double(DryRobot::Environment::Commands::ValidatePosition::Transaction) }
  let(:robot_model) { instance_double(DryRobot::Robot::Model) }

  before do
    AppContainer.stub('environment.transaction', environment_transaction)
    AppContainer.stub('robot.model', robot_model)
  end

  after do
    AppContainer.unstub('environment.transaction')
    AppContainer.unstub('robot.model')
  end

  context 'when the environment allows the move' do
    before { allow(environment_transaction).to receive(:call).and_return(Dry::Monads.Success(input)) }

    context 'when the robot accepts the move' do
      before do
        allow(robot_model).to receive_messages(place: input)
      end

      it 'returns a success' do
        expect(transaction.call(**input)).to be_success
      end
    end

    context 'when the robot does not accept the move' do
      before { allow(robot_model).to receive(:place).and_raise(DryRobot::Robot::Model::PositionError) }

      it 'returns a failure' do
        expect(transaction.call(**input)).to be_failure
      end
    end
  end

  context 'when the environment does not allow the move' do
    before { allow(environment_transaction).to receive(:call).and_return(Dry::Monads.Failure()) }

    it 'returns a failure' do
      expect(transaction.call(**input)).to be_failure
    end
  end
end
