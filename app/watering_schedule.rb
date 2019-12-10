#!/usr/bin/env ruby
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

class WateringSchedule < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  PlantData = JSON.parse(File.read('../Tandem_Apprentice_2019_Challenge/Apprentice_WeGrowInTandem_Data.json'))

  get '/' do
  	erb :index
  end

end

# class App < Sinatra::Application
# 	configure :development do
#     register Sinatra::Reloader
#   end
