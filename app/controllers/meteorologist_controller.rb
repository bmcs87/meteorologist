require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]

    # ==========================================================================
    # Your code goes below.
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================

    url = "https://api.darksky.net/forecast/7061017e8de3ec9d3d32af1b8ef4067f/"
    parsed_data = JSON.parse(open(url).read)
    @street_address = @street_address.gsub(\s+/,"+")

    @current_temperature = @street_address.parsed_data["latitude"]["timezone"]["offset"]["currently"]["temperature"]

    @current_summary = @street_address.parsed_data["latitude"]["longitude"]["timezone"]["offset"]["currently"]["summary"]

    @summary_of_next_sixty_minutes = @street_address.parsed_data["latitude"]["longitude"]["timezone"]["offset"]["minutely"]

    @summary_of_next_several_hours = @street_address.parsed_data["latitude"]["longitude"]["timezone"]["offset"]["hourly"]
    
    @summary_of_next_several_days = @street_address.parsed_data["latitude"]["longitude"]["timezone"]["offset"]["daily"]

    render("meteorologist/street_to_weather.html.erb")
  end
end
