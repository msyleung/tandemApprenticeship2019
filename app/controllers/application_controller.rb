require './config/environment'

class ApplicationController < Sinatra::Base
  helpers DateHelper

  configure do
    set :public_folder, 'app/public'
    set :views, 'app/views'
  end

  before do
    @title = 'Plant Site'
  end

  get '/' do
    @today = Day.today
    @today_plants = @today.plants
    erb :index
  end

end
