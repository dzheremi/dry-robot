require 'spec_helper'
require 'dry/monads'
require 'dry_robot/robot/commands/move/transaction'
require 'dry_robot/robot/model'
require 'dry_robot/environment/commands/validate_position/transaction'

RSpec.describe DryRobot::Robot::Commands::Move::Transaction do
  subject(:transaction) { described_class.new }

  let(:environment_valid) { Dry::Monads::Success() }
  let(:movement_possible) { true }
  let(:environment_transaction) { instance_double(DryRobot::Environment::Commands::ValidatePosition::Transaction) }
  let(:heading) { 'N' }
  let(:x_point) { 0 }
  let(:y_point) { 0 }
  let(:robot_model) do
    instance_double(
      DryRobot::Robot::Model,
      x_point:,
      y_point:,
      heading:
    )
  end

  before do
    AppContainer.stub('environment.transaction', environment_transaction)
    AppContainer.stub('robot.model', robot_model)
    allow(environment_transaction).to receive(:call).and_return(environment_valid)
    allow(robot_model).to receive(:movement_possible?).and_return(movement_possible)
    allow(robot_model).to receive(:place)
  end

  after do
    AppContainer.unstub('environment.transaction')
    AppContainer.unstub('robot.model')
  end

  context 'when the robot is placed' do
    context 'when the environment accepts the position' do
      it 'returns a success' do
        expect(transaction.call).to be_success
      end

      it 'checks if the robot can move' do
        transaction.call
        expect(robot_model).to have_received(:movement_possible?)
      end

      it 'checks with the environment to ensure a valid position' do
        transaction.call
        expect(environment_transaction).to have_received(:call).with(
          x_point: 1, y_point: 0
        )
      end

      it 'places the robot into the new position' do
        transaction.call
        expect(robot_model).to have_received(:place).with(
          x_point: 1,
          y_point: 0,
          heading: 'N'
        )
      end

      context 'when the robot is facing north' do
        it 'moves the robot up the x axis' do
          transaction.call
          expect(robot_model).to have_received(:place).with(
            x_point: 1,
            y_point: 0,
            heading: 'N'
          )
        end
      end

      context 'when the robot is facing south' do
        let(:heading) { 'S' }
        let(:x_point) { 4 }

        it 'moves the robot down the x axis' do
          transaction.call
          expect(robot_model).to have_received(:place).with(
            x_point: 3,
            y_point: 0,
            heading: 'S'
          )
        end
      end

      context 'when the robot is facing east' do
        let(:heading) { 'E' }

        it 'moves the robot up the y axis' do
          transaction.call
          expect(robot_model).to have_received(:place).with(
            x_point: 0,
            y_point: 1,
            heading: 'E'
          )
        end
      end

      context 'when the robot is facing west' do
        let(:heading) { 'W' }
        let(:y_point) { 4 }

        it 'moves the robot down the y axis' do
          transaction.call
          expect(robot_model).to have_received(:place).with(
            x_point: 0,
            y_point: 3,
            heading: 'W'
          )
        end
      end
    end
  end

  context 'when the robot is not placed' do
    let(:movement_possible) { false }

    it 'returns a failure' do
      expect(transaction.call).to be_failure
    end

    it 'checks if the robot can move' do
      transaction.call
      expect(robot_model).to have_received(:movement_possible?)
    end

    it 'does not check with the environment' do
      transaction.call
      expect(environment_transaction).not_to have_received(:call)
    end

    it 'does not move the robot' do
      transaction.call
      expect(robot_model).not_to have_received(:place)
    end
  end
end
