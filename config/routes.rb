Rails.application.routes.draw do
  get '/weather_forecasts', to: 'weather_forecasts#index'
  get '/weather_forecasts/get_forecast', to: 'weather_forecasts#get_forecast'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
