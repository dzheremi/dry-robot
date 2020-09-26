# frozen_string_literal: true

require 'spec_helper'
require 'dry_robot/commands/types'

RSpec.describe DryRobot::Commands::Types do
  describe 'base command arguments' do
    subject(:command_arguments) { DryRobot::Commands::Types::BaseCommandArguments }

    context 'with valid commands' do
      %w[PLACE MOVE LEFT RIGHT REPORT].each do |command|
        it "accepts the #{command} command" do
          expect(command_arguments[command]).to eq(command)
        end
      end
    end

    context 'with invalid commands' do
      it 'rejects an unknown command' do
        expect { command_arguments['DANCE'] }.to raise_error(Dry::Types::ConstraintError)
      end

      it 'rejects malformed known commands' do
        expect { command_arguments['MOVE '] }.to raise_error(Dry::Types::ConstraintError)
        expect { command_arguments[' PLACE'] }.to raise_error(Dry::Types::ConstraintError)
      end
    end
  end

  describe 'position arguments' do
    subject(:position_argument) { DryRobot::Commands::Types::PositionArgument }

    context 'with a valid position' do
      (1..5).each do |x|
        (1..5).each do |y|
          %w[N S E W].each do |f|
            it "accepts the position #{x}, #{y}, #{f}" do
              expect(position_argument["#{x},#{y},#{f}"]).to eq("#{x},#{y},#{f}")
            end
          end
        end
      end
    end

    context 'with an invalid position' do
      context 'when the coordinates are out of bounds' do
        it 'rejects the position' do
          expect { position_argument['9, 8, N'] }.to raise_error(Dry::Types::ConstraintError)
        end
      end

      context 'when the direction is malformed' do
        it 'rejects the position' do
          expect { position_argument['9, 8, T'] }.to raise_error(Dry::Types::ConstraintError)
        end
      end

      context 'with a completely malformed position' do
        it 'rejects the position' do
          expect { position_argument['The Rabit Hole'] }.to raise_error(Dry::Types::ConstraintError)
        end
      end
    end
  end
end
