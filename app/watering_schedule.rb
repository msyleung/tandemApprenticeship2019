#!/usr/bin/env ruby
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require_relative 'helpers/date'

class WateringSchedule < Sinatra::Base
  helpers DateHelper
  helpers PlantScheduler

  configure :development do
    register Sinatra::Reloader
  end

  before do
    # load plants
    plants ||= JSON.parse(File.read('../Tandem_Apprentice_2019_Challenge/Apprentice_WeGrowInTandem_Data.json'))
    # set title :D
    @title = "Plant Site"
  end

  get '/' do
  	erb :index
  end

  get '/plants' do
    erb :all
  end

end
