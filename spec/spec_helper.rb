require File.expand_path("../../config/environment", __FILE__)

ENV['SINATRA_ENV'] = 'test'

ActiveRecord::Base.logger = Logger.new('spec/spec.log')

RSpec.configure do |config|
  config.color = true
  # needs Rails 5
  # config.infer_spec_type_from_file_location!
end
