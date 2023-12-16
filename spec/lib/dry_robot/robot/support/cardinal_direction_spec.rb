require 'spec_helper'
require 'dry_robot/robot/support/cardinal_direction'

RSpec.describe DryRobot::Robot::Support::CardinalDirection do
  describe '#rotate' do
    context 'with a valid current heading' do
      context 'with a valid rotation' do
        context 'when rotating clockwise' do
          it 'rotates from north' do
            expect(described_class.rotate(heading: 'N')).to eq('E')
          end

          it 'rotates from east' do
            expect(described_class.rotate(heading: 'E')).to eq('S')
          end

          it 'rotates from south' do
            expect(described_class.rotate(heading: 'S')).to eq('W')
          end

          it 'rotates from west' do
            expect(described_class.rotate(heading: 'W')).to eq('N')
          end
        end

        context 'when rotating counter-clockwise' do
          it 'rotates from north' do
            expect(described_class.rotate(heading: 'N', rotation: :counter_clockwise)).to eq('W')
          end

          it 'rotates from east' do
            expect(described_class.rotate(heading: 'W', rotation: :counter_clockwise)).to eq('S')
          end

          it 'rotates from south' do
            expect(described_class.rotate(heading: 'S', rotation: :counter_clockwise)).to eq('E')
          end

          it 'rotates from west' do
            expect(described_class.rotate(heading: 'E', rotation: :counter_clockwise)).to eq('N')
          end
        end
      end

      context 'with an invalid rotation' do
        it 'raises an error' do
          expect do
            described_class.rotate(heading: 'N',
                                   rotation: :something_silly)
          end.to raise_error(DryRobot::Robot::Support::CardinalDirection::InvalidRotationError)
        end
      end
    end

    context 'with an invalid current heading' do
      it 'raises an error' do
        expect do
          described_class.rotate(heading: 'Z')
        end.to raise_error(DryRobot::Robot::Support::CardinalDirection::InvalidHeadingError)
      end
    end
  end
end
