require 'spec_helper'
require 'dry_robot/robot/model'

RSpec.describe DryRobot::Robot::Model do
  subject(:model) { described_class.new(**params) }

  describe '#initialize' do
    context 'with valid options' do
      let(:params) do
        {
          x_point: 1,
          y_point: 2,
          heading: 'W'
        }
      end

      it 'initializes with the correct attributes' do
        expect(model).to have_attributes(
          x_point: 1,
          y_point: 2,
          heading: 'W'
        )
      end
    end

    context 'with no options' do
      let(:params) { {} }

      it 'initializes with the correct attributes' do
        expect(model).to have_attributes(
          x_point: nil,
          y_point: nil,
          heading: nil
        )
      end
    end

    context 'with invalid options' do
      let(:params) do
        {
          x_point: 'Somewhere',
          y_point: 2,
          heading: 'NNW'
        }
      end

      it 'raises an error' do
        expect { model }.to raise_error(Dry::Types::ConstraintError)
      end
    end
  end

  describe '.report' do
    context 'with a valid position' do
      let(:params) { { x_point: 1, y_point: 1, heading: 'S' } }

      it 'reports it\'s location' do
        expect(model.report).to eq('1,1,S')
      end
    end

    context 'with no position' do
      let(:params) { {} }

      it 'reports no position' do
        expect(model.report).to eq('No Position')
      end
    end
  end

  describe '.place' do
    context 'with a valid position' do
      let(:params) { {} }

      it 'updates the robots position' do
        model.place(x_point: 1, y_point: 1, heading: 'S')
        expect(model).to have_attributes(
          x_point: 1,
          y_point: 1,
          heading: 'S'
        )
      end
    end

    context 'with an invalid position' do
      let(:params) { {} }

      it 'raises an exception' do
        expect do
          model.place(x_point: 'Somewhere', y_point: 1, heading: 'Q')
        end.to raise_error(DryRobot::Robot::Model::PositionError)
      end
    end
  end

  describe '.turn_right' do
    context 'when the robot is placed' do
      let(:params) do
        {
          x_point: 1,
          y_point: 1,
          heading:
        }
      end

      context 'when facing north' do
        let(:heading) { 'N' }

        it 'turns to the east' do
          model.turn_right
          expect(model.heading).to eq('E')
        end
      end

      context 'when facing east' do
        let(:heading) { 'E' }

        it 'turns to the south' do
          model.turn_right
          expect(model.heading).to eq('S')
        end
      end

      context 'when facing south' do
        let(:heading) { 'S' }

        it 'turns to the west' do
          model.turn_right
          expect(model.heading).to eq('W')
        end
      end

      context 'when facing west' do
        let(:heading) { 'W' }

        it 'turns to the north' do
          model.turn_right
          expect(model.heading).to eq('N')
        end
      end
    end

    context 'when the robot is not placed' do
      let(:params) { {} }

      it 'raises and error' do
        expect { model.turn_right }.to raise_error(DryRobot::Robot::Model::MovementNotPossibleError)
      end
    end
  end

  describe '.turn_left' do
    context 'when the robot is placed' do
      let(:params) do
        {
          x_point: 1,
          y_point: 1,
          heading:
        }
      end

      context 'when facing north' do
        let(:heading) { 'N' }

        it 'turns to the west' do
          model.turn_left
          expect(model.heading).to eq('W')
        end
      end

      context 'when facing west' do
        let(:heading) { 'W' }

        it 'turns to the south' do
          model.turn_left
          expect(model.heading).to eq('S')
        end
      end

      context 'when facing south' do
        let(:heading) { 'S' }

        it 'turns to the east' do
          model.turn_left
          expect(model.heading).to eq('E')
        end
      end

      context 'when facing east' do
        let(:heading) { 'E' }

        it 'turns to the north' do
          model.turn_left
          expect(model.heading).to eq('N')
        end
      end
    end

    context 'when the robot is not placed' do
      let(:params) { {} }

      it 'raises and error' do
        expect { model.turn_left }.to raise_error(DryRobot::Robot::Model::MovementNotPossibleError)
      end
    end
  end

  describe '.next_movement' do
    context 'when the robot is placed' do
      let(:params) do
        {
          x_point: 0,
          y_point: 0,
          heading:
        }
      end

      context 'when facing north' do
        let(:heading) { 'N' }

        it 'moves one space up' do
          expect(model.next_movement).to eq(
            { x_point: 1, y_point: 0 }
          )
        end
      end

      context 'when facing south' do
        let(:heading) { 'S' }

        it 'moves one space up' do
          expect(model.next_movement).to eq(
            { x_point: -1, y_point: 0 }
          )
        end
      end

      context 'when facing east' do
        let(:heading) { 'E' }

        it 'moves one space right' do
          expect(model.next_movement).to eq(
            { x_point: 0, y_point: 1 }
          )
        end
      end

      context 'when facing west' do
        let(:heading) { 'W' }

        it 'moves one space left' do
          expect(model.next_movement).to eq(
            { x_point: 0, y_point: -1 }
          )
        end
      end
    end

    context 'when the robot is not placed' do
      let(:params) { {} }

      it 'raises and error' do
        expect { model.next_movement }.to raise_error(DryRobot::Robot::Model::MovementNotPossibleError)
      end
    end
  end

  describe '.move' do
    context 'when the robot is placed' do
      let(:params) do
        {
          x_point: 0,
          y_point: 0,
          heading: 'N'
        }
      end

      it 'moves to the next_movement position' do
        model.move
        expect(model).to have_attributes(
          x_point: 1,
          y_point: 0
        )
      end
    end

    context 'when the robot is not placed' do
      let(:params) { {} }

      it 'raises and error' do
        expect { model.move }.to raise_error(DryRobot::Robot::Model::MovementNotPossibleError)
      end
    end
  end
end
