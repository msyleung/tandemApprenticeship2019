require 'bundler'

ENV['SINATRA_ENV'] ||= "development"

configure :development do
  Bundler.require(:default, ENV['SINATRA_ENV'])
  ActiveRecord::Base.establish_connection(
   :adapter => 'postgresql',
   :database => "plant_#{ENV['SINATRA_ENV']}"
 )end

configure :production do
  Bundler.require
  ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] ||'postgres://localhost/mydb')
end

ActiveRecord::Base.logger = Logger.new(STDOUT)

Dir.glob('./app/{helpers,controllers,models}/*.rb').each { |file| require file }
