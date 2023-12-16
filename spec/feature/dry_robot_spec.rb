RSpec.describe 'DryRobot' do
  context 'with valid commands' do
    let(:commands) do
      [
        'PLACE 0,0,N',
        'MOVE',
        'MOVE',
        'MOVE',
        'RIGHT',
        'MOVE',
        'MOVE'
      ]
    end

    before do
      commands.each do |command|
        AppContainer['commands.adapter'].call(command:)
      end
    end

    it 'keeps track of the robots movements' do
      expect(AppContainer['commands.adapter'].call(command: 'REPORT')).to be_success
      expect(AppContainer['commands.adapter'].call(command: 'REPORT').value!).to eq('3,2,E')
    end
  end

  context 'with commands leading to a fall' do
    let(:commands) do
      [
        'PLACE 0,0,N',
        'MOVE',
        'MOVE',
        'MOVE',
        'MOVE'
      ]
    end

    before do
      commands.each do |command|
        AppContainer['commands.adapter'].call(command:)
      end
    end

    it 'prevents the robot falling off the table' do
      expect(AppContainer['commands.adapter'].call(command: 'MOVE')).to be_failure
    end
  end
end
