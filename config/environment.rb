require 'bundler'
Bundler.require

ENV['SINATRA_ENV'] ||= "development"

configure :development do
  Bundler.require(:default, ENV['SINATRA_ENV'])
  ActiveRecord::Base.establish_connection(
   :adapter => 'postgresql',
   :database => "plant_#{ENV['SINATRA_ENV']}"
 )end

configure :production do
   ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] ||'postgres://localhost/mydb')
end

ActiveRecord::Base.logger = Logger.new(STDOUT)

# THIS LINE was giving me H10 Error on Heroku (cries)
# Dir.glob('./app/{helpers,controllers,models}/*.rb').each { |file| require file }
# The order of the require matters :^D
# Tho, I'm not sure why it gave me an error?
# 2.4.1 :003 > Dir['./app/{helpers,controllers,models}/*.rb']
 # => ["./app/helpers/date.rb", "./app/helpers/request.rb", "./app/controllers/application_controller.rb", "./app/controllers/plants_controller.rb", "./app/controllers/days_controller.rb", "./app/models/plantday.rb", "./app/models/day.rb", "./app/models/plant.rb"]
# irb says they were all in the correct order as they should be
# Maybe Heroku will break again later, but at least it's more line specific now which one it's breaking at
# source: https://www.thoughtco.com/using-glob-with-directories-2907832
Dir.glob('./app/helpers/*.rb').each { |file| require file }
require './app/controllers/application_controller.rb'
Dir.glob('./app/controllers/{plants,days}_controller.rb').each { |file| require file }
Dir.glob('./app/models/*.rb').each { |file| require file }
