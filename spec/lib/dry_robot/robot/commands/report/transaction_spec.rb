require 'spec_helper'
require 'dry_robot/robot/commands/report/transaction'
require 'dry_robot/robot/model'

RSpec.describe DryRobot::Robot::Commands::Report::Transaction do
  subject(:transaction) { described_class.new }

  let(:robot_model) do
    instance_double(
      DryRobot::Robot::Model,
      x_point: 4,
      y_point: 4,
      heading: 'N'
    )
  end
  let(:movement_possible) { true }

  before do
    AppContainer.stub('robot.model', robot_model)
    allow(robot_model).to receive(:movement_possible?).and_return(movement_possible)
  end

  after do
    AppContainer.unstub('robot.model')
  end

  context 'when the robot is placed' do
    it 'returns a success' do
      expect(transaction.call).to be_success
    end

    it 'checks if the robot can move' do
      transaction.call
      expect(robot_model).to have_received(:movement_possible?)
    end

    it 'returns the robot location' do
      expect(transaction.call.value!).to eq('4,4,N')
    end
  end

  context 'when the robot is not placed' do
    let(:movement_possible) { false }

    it 'returns a success' do
      expect(transaction.call).to be_success
    end

    it 'checks if the robot can move' do
      transaction.call
      expect(robot_model).to have_received(:movement_possible?)
    end

    it 'returns no position' do
      expect(transaction.call.value!).to eq('No Position')
    end
  end
end
