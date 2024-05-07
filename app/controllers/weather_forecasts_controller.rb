# app/controllers/weather_forecasts_controller.rb
class WeatherForecastsController < ApplicationController
    def index
        render template: 'layouts/weather_forecasts/index', locals: { forecast: @forecast }
    end

    def get_forecast
      zip_code = extract_zipcode(params[:address])
      forecast = WeatherForecastService.new(zip_code).fetch_forecast
      tomorrow_forecast = WeatherForecastService.new(zip_code).fetch_tomorrow_forecast
      render partial: 'layouts/weather_forecasts/forecast_result', locals: { forecast: forecast, tomorrow_forecast: tomorrow_forecast }, 
      layout: false
    end


    private

    def extract_zipcode(address)
      zip_code = address[-6..-1] || address[-5..-1]
    
      zip_code
    end
end
  