require 'spec_helper'
require 'dry_robot/robot/commands/left/transaction'
require 'dry_robot/robot/model'
require 'dry_robot/robot/support/cardinal_direction'

RSpec.describe DryRobot::Robot::Commands::Left::Transaction do
  subject(:transaction) { described_class.new }

  let(:movement_possible) { true }
  let(:heading) { 'N' }
  let(:robot_model) do
    instance_double(
      DryRobot::Robot::Model,
      x_point: 0,
      y_point: 0,
      heading: :heading
    )
  end

  before do
    AppContainer.stub('robot.model', robot_model)
    allow(robot_model).to receive(:movement_possible?).and_return(movement_possible)
    allow(robot_model).to receive(:place)
    allow(DryRobot::Robot::Support::CardinalDirection)
      .to receive(:rotate).with(heading: :heading,
                                rotation: :counter_clockwise).and_return('Z')
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

    it 'places the robot into the new position' do
      transaction.call
      expect(robot_model).to have_received(:place).with(
        x_point: 0,
        y_point: 0,
        heading: 'Z'
      )
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

    it 'does not move the robot' do
      transaction.call
      expect(robot_model).not_to have_received(:place)
    end
  end
end
