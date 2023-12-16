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
          x_point: Dry::Initializer::UNDEFINED,
          y_point: Dry::Initializer::UNDEFINED,
          heading: Dry::Initializer::UNDEFINED
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

  describe '.movement_possible?' do
    context 'with a valid position' do
      let(:params) do
        {
          x_point: 1,
          y_point: 2,
          heading: 'W'
        }
      end

      it 'returns true' do
        expect(model.movement_possible?).to be true
      end
    end

    context 'with no valid position' do
      let(:params) { {} }

      it 'returns false' do
        expect(model.movement_possible?).to be false
      end
    end
  end
end
