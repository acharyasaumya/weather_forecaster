# app/controllers/weather_forecasts_controller.rb
class WeatherForecastsController < ApplicationController
    def index
        render template: 'layouts/weather_forecasts/index', locals: { forecast: @forecast }
    end

    def get_forecast
      zip_code = extract_zipcode(params[:address])
      forecast, from_cache = cached_forecast(zip_code)
      tomorrow_forecast = WeatherForecastService.new(zip_code).fetch_tomorrow_forecast
      render partial: 'layouts/weather_forecasts/forecast_result', locals: { forecast: forecast, tomorrow_forecast: tomorrow_forecast, from_cache: from_cache  }, 
      layout: false
    end


    private

    def extract_zipcode(address)
      zip_code = address[-6..-1] || address[-5..-1]
    
      zip_code
    end

    def cached_forecast(zip_code)
      cache_key = "weather_forecast_#{zip_code}"
      forecast = Rails.cache.fetch(cache_key, expires_in: 30.minutes) do
        fetch_and_cache_forecast(zip_code)
      end
      from_cache = forecast.present?
      [forecast, from_cache]
    end
  
    def fetch_and_cache_forecast(zip_code)
      forecast = WeatherForecastService.new(zip_code).fetch_forecast
      forecast.merge(from_cache: false)
    end
end
  