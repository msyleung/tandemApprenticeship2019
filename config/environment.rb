require 'bundler'
Bundler.require

ENV['SINATRA_ENV'] ||= "development"

configure :development, :production do
 ActiveRecord::Base.establish_connection(
   :adapter => 'postgresql',
   :database => "plant_#{ENV['SINATRA_ENV']}"
 )
end

ActiveRecord::Base.logger = Logger.new(STDOUT)

Dir.glob('./app/{helpers,controllers,models}/*.rb').each { |file| require file }
