require 'simplecov'
SimpleCov.start

require 'brightness'

RSpec.configure do |config|
  config.color = true
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.filter_run_excluding :slow unless ENV['SLOW_SPECS']

  config.before(:each) { GC.disable }
  config.after(:each) { GC.enable }
end