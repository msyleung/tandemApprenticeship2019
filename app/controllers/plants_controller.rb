require './config/environment'

class PlantsController < ApplicationController

  get '/plants' do
    @plants ||= Plant.all
    erb :'plants/index'
  end

  get '/plants/:id' do
    @plant = Plant.find(params[:id])
    erb :'plants/show'
  end

end
