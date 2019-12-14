require './config/environment'

class ApplicationController < Sinatra::Base
  helpers DateHelper

  configure do
    set :public_folder, 'app/public'
    set :views, 'app/views'
  end

  configure :production, :development do
    enable :logging
  end

  before do
    @title = 'Plant Site'
  end

  get '/' do
    @today = Day.where(date: '2019-12-16').first#Day.today
    @today_plants = @today.plants
    erb :index
  end

end
