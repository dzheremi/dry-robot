# frozen_string_literal: true

require 'spec_helper'
require 'dry_robot/environment/tabletop/model'

RSpec.describe DryRobot::Environment::Tabletop::Model do
  subject(:model) { described_class.new }

  describe '.valid_position?' do
    context 'when position is on the surface of the tabletop' do
      (0..4).each do |x_point|
        (0..4).each do |y_point|
          it 'returns true' do
            expect(model.valid_position?(x_point: x_point, y_point: y_point)).to be true
          end
        end
      end
    end

    context 'when the position is not on the surface of the tabletop' do
      context 'when one value is out of bounds' do
        it 'returns false' do
          expect(model.valid_position?(x_point: 3, y_point: 5)).to be false
          expect(model.valid_position?(x_point: 5, y_point: 3)).to be false
          expect(model.valid_position?(x_point: 3, y_point: -1)).to be false
          expect(model.valid_position?(x_point: -1, y_point: 3)).to be false
        end
      end

      context 'when both values are out of bounds' do
        it 'returns false' do
          expect(model.valid_position?(x_point: 5, y_point: 5)).to be false
          expect(model.valid_position?(x_point: -1, y_point: -1)).to be false
        end
      end
    end
  end
end
