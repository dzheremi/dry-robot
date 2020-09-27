# frozen_string_literal: true

require 'dry/system/container'

class AppContainer < Dry::System::Container
  load_paths!('lib')
  configure do |config|
    config.default_namespace = 'dry_robot'
    config.system_dir = Pathname('./lib/system')
  end
end
