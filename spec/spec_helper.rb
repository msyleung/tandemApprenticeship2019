require_relative '../config/environment'

ActiveRecord::Base.logger = Logger.new('spec/spec.log')

RSpec.configure do |config|
  config.color = true
  # needs Rails 5
  # config.infer_spec_type_from_file_location!
end
