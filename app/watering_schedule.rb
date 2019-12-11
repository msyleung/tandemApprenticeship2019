#!/usr/bin/env ruby
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require_relative 'helpers/date'
require_relative 'helpers/plant'

class WateringSchedule < Sinatra::Base
  helpers DateHelper
  helpers Plant

  configure :development do
    register Sinatra::Reloader
  end

  before do
    load_plants()
    water_all()
    sort_by_plant_dates()
    # set title :D
    @title = "Plant Site"
  end

  get '/' do
    erb :index
  end

  get '/dates' do
    erb :all_dates
  end

  get '/plants' do
    erb :all_plants
  end

  get '/:date' do
    date = Time.parse(params[:date]) rescue nil
    redirect '/' if date.nil?
    if @plant_dates.has_key?(date)
      erb :'partial/_page', locals: { date: date, plants: @plant_dates[date] }
    else
      erb :'partial/_error'
    end
  end

  # something is wrong with the route above that breaks this /test route
  # it constantly gives ArgumentError - no time information in "favicon.ico"
  # .../watering_schedule.rb:37:in `block in <class:WateringSchedule>'
  # something to do with the params?
  # oh, omfg GET /favicon.ico that's why. I need to specify the param...
  # get '/test' do
  #   erb :test
  #

end
