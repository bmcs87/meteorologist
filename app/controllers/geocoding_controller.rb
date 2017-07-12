require 'open-uri'

class GeocodingController < ApplicationController
  def street_to_coords_form
    # Nothing to do here.
    render("geocoding/street_to_coords_form.html.erb")
  end

  def street_to_coords
    @street_address = params[:user_street_address]
    
    # convert street address from array to string with +'s between each word, add it onto url

    # ==========================================================================
    # Your code goes below..
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================

    url = "https://maps.googleapis.com/maps/api/geocode/json?address="
    
    #@street_address = @street_address.gsub(\s+/,"+")
    #why doesn't the @street_address work?  it seems like that formula should work
    url.join(@street_address)
    
    parsed_data = JSON.parse(open(url).read)

    @latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]

    @longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]

    render("geocoding/street_to_coords.html.erb")
  end
end
