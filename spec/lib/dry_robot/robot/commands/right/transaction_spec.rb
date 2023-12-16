require 'spec_helper'
require 'dry_robot/robot/commands/right/transaction'
require 'dry_robot/robot/model'

RSpec.describe DryRobot::Robot::Commands::Right::Transaction do
  subject(:transaction) { described_class.new }

  let(:robot_model) { instance_double(DryRobot::Robot::Model) }

  before do
    AppContainer.stub('robot.model', robot_model)
  end

  after do
    AppContainer.unstub('robot.model')
  end

  context 'when the robot accepts the move' do
    before do
      allow(robot_model).to receive_messages(turn_right: true, report: 'Good')
    end

    it 'returns a success' do
      expect(transaction.call).to be_success
    end
  end

  context 'when the robot does not accept the move' do
    before { allow(robot_model).to receive(:turn_right).and_raise(DryRobot::Robot::Model::MovementNotPossibleError) }

    it 'returns a failure' do
      expect(transaction.call).to be_failure
    end
  end
end
