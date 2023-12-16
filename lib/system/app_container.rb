require 'dry/system'

class AppContainer < Dry::System::Container
  configure do |config|
    config.component_dirs.add 'lib'
  end
end
