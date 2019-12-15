class PlantsController < ApplicationController

  get '/plants' do
    @plants ||= Plant.all
    link = :'plants/index'
    pretty_response(link, @plants)
  end

  get '/plants/:id' do
    @plant = Plant.find(params[:id])
    erb :'plants/show'
  end

end
