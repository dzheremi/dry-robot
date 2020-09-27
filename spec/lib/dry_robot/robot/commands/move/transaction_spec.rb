# frozen_string_literal: true

require 'spec_helper'
require 'dry_robot/robot/commands/move/transaction'
require 'dry_robot/robot/model'
require 'dry_robot/environment/commands/validate_position/transaction'

RSpec.describe DryRobot::Robot::Commands::Move::Transaction do
  subject(:transaction) { described_class.new }

  let(:input) { { x_point: 3, y_point: 4 } }
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
        allow(robot_model).to receive(:next_movement).and_return(input)
        allow(robot_model).to receive(:move).and_return(input)
        allow(robot_model).to receive(:report).and_return('Good')
      end

      it 'returns a success' do
        expect(transaction.call).to be_success
      end
    end

    context 'when the robot does not accept the move' do
      before do
        allow(robot_model).to receive(:next_movement).and_raise(DryRobot::Robot::Model::MovementNotPossibleError)
        allow(robot_model).to receive(:move).and_return(input)
      end

      it 'returns a failure' do
        expect(transaction.call).to be_failure
      end
    end
  end

  context 'when the environment does not allow the move' do
    before do
      allow(robot_model).to receive(:next_movement).and_return(input)
      allow(environment_transaction).to receive(:call).and_return(Dry::Monads.Failure())
    end

    it 'returns a failure' do
      expect(transaction.call).to be_failure
    end
  end
end
