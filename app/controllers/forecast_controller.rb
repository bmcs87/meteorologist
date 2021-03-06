require 'open-uri'

class ForecastController < ApplicationController
  def coords_to_weather_form
    # Nothing to do here.
    render("forecast/coords_to_weather_form.html.erb")
  end

  def coords_to_weather
    @lat = params[:user_latitude]
    @lng = params[:user_longitude]

    # ==========================================================================
    # Your code goes below.
    # The latitude the user input is in the string @lat.
    # The longitude the user input is in the string @lng.
    # ==========================================================================

  
    url = "https://api.darksky.net/forecast/7061017e8de3ec9d3d32af1b8ef4067f/"
    url = url + @lat, +@lng
    parsed_data = JSON.parse(open(url).read)
  
    @current_temperature = parsed_data["latitude"]["longitude"]["timezone"]["offset"]["currently"]["temperature"]

    @current_summary = parsed_data["latitude"]["longitude"]["timezone"]["offset"]["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_data["latitude"]["longitude"]["timezone"]["offset"]["minutely"]

    @summary_of_next_several_hours = parsed_data["latitude"]["longitude"]["timezone"]["offset"]["hourly"]
    
    @summary_of_next_several_days = parsed_data["latitude"]["longitude"]["timezone"]["offset"]["daily"]

    render("forecast/coords_to_weather.html.erb")
  end
end
