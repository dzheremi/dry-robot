# frozen_string_literal: true

require 'spec_helper'
require 'dry_robot/commands/types'

RSpec.describe DryRobot::Commands::Types do
  describe 'single command arguments' do
    subject(:command_arguments) { DryRobot::Commands::Types::SingleCommandArguments }

    context 'with valid commands' do
      %w[MOVE LEFT RIGHT REPORT].each do |command|
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
        expect { command_arguments['move please'] }.to raise_error(Dry::Types::ConstraintError)
      end
    end
  end

  describe 'position command arguments' do
    subject(:command_arguments) { DryRobot::Commands::Types::PositionCommandArguments }

    context 'with valid commands' do
      it 'accepts the PLACE command' do
        expect(command_arguments['PLACE']).to eq('PLACE')
      end
    end

    context 'with invalid commands' do
      it 'rejects an unknown command' do
        expect { command_arguments['DANCE'] }.to raise_error(Dry::Types::ConstraintError)
      end

      it 'rejects malformed known commands' do
        expect { command_arguments['place'] }.to raise_error(Dry::Types::ConstraintError)
      end
    end
  end

  describe 'position arguments' do
    subject(:position_argument) { DryRobot::Commands::Types::PositionArgument }

    context 'with a valid position' do
      (0..4).each do |x|
        (0..4).each do |y|
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

  describe 'command parsing' do
    subject(:command_parser) { DryRobot::Commands::Types::Command }

    context 'with single commands' do
      context 'with valid input' do
        %w[MOVE LEFT RIGHT REPORT].each do |command|
          it 'returns the command as an array' do
            expect(command_parser[command]).to be_an(Array)
          end

          it 'returns an array with only one instruction' do
            expect(command_parser[command].size).to eq(1)
          end

          it 'accepts the command' do
            expect(command_parser[command]).to eq([command])
          end
        end
      end

      context 'with invalid input' do
        it 'rejects unknown commands' do
          expect { command_parser['DANCE'] }.to raise_error(Dry::Types::ConstraintError)
        end

        it 'rejects malformed commands' do
          expect { command_parser['left'] }.to raise_error(Dry::Types::ConstraintError)
        end
      end
    end

    context 'with the position commands' do
      context 'with valid input' do
        let(:command) { 'PLACE 1,1,N' }

        it 'returns the command as an array' do
          expect(command_parser[command]).to be_an(Array)
        end

        it 'returns an array with only two instructions' do
          expect(command_parser[command].size).to eq(2)
        end

        it 'accepts the command' do
          expect(command_parser[command]).to eq(['PLACE', '1,1,N'])
        end
      end

      context 'with invalid input' do
        context 'with two unknown commands' do
          it 'rejects the command' do
            expect { command_parser['PERFORM BACKFLIP'] }.to raise_error(Dry::Types::ConstraintError)
          end
        end

        context 'with a malformed position' do
          it 'rejects the command' do
            expect { command_parser['PLACE 1232,N'] }.to raise_error(Dry::Types::ConstraintError)
          end
        end

        context 'with a position which is out of bounds' do
          it 'rejects the command' do
            expect { command_parser['PLACE 5,6,N'] }.to raise_error(Dry::Types::ConstraintError)
          end
        end
      end
    end
  end
end
