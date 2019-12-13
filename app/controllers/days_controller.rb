class DaysController < ApplicationController

  get '/days' do
    @days ||= Day.all.sort_by(&:date)
    erb :'days/index'
  end

  get '/days/:date' do
    @current_day = Day.find_or_create_by(date: params[:date])
    erb :'days/show'
  end

end
