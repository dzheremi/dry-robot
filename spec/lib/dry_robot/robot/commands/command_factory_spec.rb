require 'spec_helper'
require 'dry_robot/robot/commands/command_factory'

RSpec.describe DryRobot::Robot::Commands::CommandFactory do
  subject(:command_factory) { described_class.new }

  describe 'fetch' do
    context 'with the left command identifier' do
      it 'returns the command' do
        command = command_factory.fetch(command_identifier: 'left')
        expect(command).to be_a(DryRobot::Robot::Commands::Left::Transaction)
      end
    end

    context 'with the move command identifier' do
      it 'returns the command' do
        command = command_factory.fetch(command_identifier: 'move')
        expect(command).to be_a(DryRobot::Robot::Commands::Move::Transaction)
      end
    end

    context 'with the place command identifier' do
      it 'returns the command' do
        command = command_factory.fetch(command_identifier: 'place')
        expect(command).to be_a(DryRobot::Robot::Commands::Place::Transaction)
      end
    end

    context 'with the report command identifier' do
      it 'returns the command' do
        command = command_factory.fetch(command_identifier: 'report')
        expect(command).to be_a(DryRobot::Robot::Commands::Report::Transaction)
      end
    end

    context 'with the right command identifier' do
      it 'returns the command' do
        command = command_factory.fetch(command_identifier: 'right')
        expect(command).to be_a(DryRobot::Robot::Commands::Right::Transaction)
      end
    end

    context 'with an invalid identifier' do
      it 'returns nil' do
        command = command_factory.fetch(command_identifier: 'salami')
        expect(command).to be_nil
      end
    end
  end
end
