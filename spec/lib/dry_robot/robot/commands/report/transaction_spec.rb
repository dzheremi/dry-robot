require 'spec_helper'
require 'dry_robot/robot/commands/report/transaction'
require 'dry_robot/robot/model'

RSpec.describe DryRobot::Robot::Commands::Report::Transaction do
  subject(:transaction) { described_class.new }

  let(:robot_model) { instance_double(DryRobot::Robot::Model) }

  before do
    AppContainer.stub('robot.model', robot_model)
    allow(robot_model).to receive(:report).and_return('Here')
  end

  after do
    AppContainer.unstub('robot.model')
  end

  it 'returns a success' do
    expect(transaction.call).to be_success
  end

  it 'returns the robot location' do
    expect(transaction.call.value!).to eq('Here')
  end
end
