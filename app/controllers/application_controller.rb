require './config/environment'

class ApplicationController < Sinatra::Base
  helpers DateHelper
  helpers RequestHelper

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
    @today = Day.today
    @today_plants = @today.plants
    erb :index
  end

end
