ENV['SINATRA_ENV'] ||= "development"
require 'bundler'

Bundler.require(:default, ENV['SINATRA_ENV'])

ActiveRecord::Base.establish_connection(
  if ENV['SINATRA_ENV'].production?
    :adapter => "postgresql",
    :database => "db/plant_#{ENV['SINATRA_ENV']}"
  else
  :adapter => "sqlite3",
  :database => "db/plant_#{ENV['SINATRA_ENV']}.sqlite"
  end
)

ActiveRecord::Base.logger = Logger.new(STDOUT)

Dir.glob('./app/{helpers,controllers,models}/*.rb').each { |file| require file }
