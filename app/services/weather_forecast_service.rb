# app/services/weather_forecast_service.rb
class WeatherForecastService
    require 'geocoder'
  
    def initialize(zip_code)
      @zip_code = zip_code
    end
  
    def fetch_forecast
      latitude, longitude = geocode_zip_code(@zip_code)
      fetch_weather(latitude, longitude)
    end
  
    def fetch_tomorrow_forecast
      latitude, longitude = geocode_zip_code(@zip_code)
      fetch_weather(latitude, longitude, tomorrow: true)
    end
  
    private
  
    def geocode_zip_code(zip_code)
      result = Geocoder.search(zip_code).first
      [result.latitude, result.longitude] if result.present?
    end
  
    def fetch_weather(latitude, longitude, tomorrow: false)
      api_key = "bb527cb7603d67bf61849617b6685490"
      url = "https://api.openweathermap.org/data/3.0/onecall?lat=#{latitude}&lon=#{longitude}&exclude=&appid=#{api_key}"
      response = HTTParty.get(url)
      Rails.logger.info("lat is #{latitude} lon is #{longitude}")
      Rails.logger.info("response is #{response["daily"]}")
  
      forecast_data = {
        temperature: response["current"]["temp"],
        description: response["current"]["weather"][0]["description"],
        high_temperature: response["daily"][0]["temp"]["max"],
        low_temperature: response["daily"][0]["temp"]["min"],
        from_cache: false # Assuming 'weather' contains extended forecast
      }
  
      if tomorrow
        forecast_data[:min_temp] = response["daily"][1]["temp"]["min"]
        forecast_data[:max_temp] = response["daily"][1]["temp"]["max"]
        forecast_data[:summary] = response["daily"][1]["weather"][0]["description"]
      end
  
      forecast_data
    end
  end
  