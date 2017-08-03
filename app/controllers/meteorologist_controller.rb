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

    @url = "https://maps.googleapis.com/maps/api/geocode/json?address="
    
    @street_address_with_spaces = []
    
    @street_address_to_array = @street_address.split
    
    @street_address_to_array.each do |word|
      new_word = word + "+"
      @street_address_with_spaces.push(new_word)
    end
    
    @street_address_with_spaces = @street_address_with_spaces.to_s
    
    @google_url = @url + @street_address + "&key=AIzaSyAWJkaq3BE5yVEaD94PWiKBNWuqbX5IvVM"
    
    parsed_data = JSON.parse(open(@google_url).read)

        @url2 = "https://api.darksky.net/forecast/7061017e8de3ec9d3d32af1b8ef4067f/"

    @latitude = parsed_data.dig("results",0,"geometry","location","lat").to_s

    @longitude = parsed_data.dig("results",0,"geometry","location","lng").to_s
    
    @darksky_url = @url2 + @latitude + "," + @longitude
    
    parsed_data2 = JSON.parse(open(@darksky_url).read)

    @current_temperature = parsed_data2.dig("currently","temperature")

    @current_summary = parsed_data2.dig("currently","summary")

    @summary_of_next_sixty_minutes = parsed_data2.dig("minutely","summary")

    @summary_of_next_several_hours = parsed_data2.dig("hourly","summary")

    @summary_of_next_several_days = parsed_data2.dig("daily","summary")

    render("meteorologist/street_to_weather.html.erb")
  end
end
