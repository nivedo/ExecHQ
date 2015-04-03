class SplashController < ApplicationController
  def index
    @splash_override = true
  end

  def search
    @splash_override = true
    @use_gmap = true
    @hotel_list = {}

    # Instentiate api object
    # api = Expedia::Api.new

=begin
    # SJC Airport
    response = api.get_list({:latitude => "37.3628", :longitude => "-121.9292", 
      :sort => "PROXIMITY", :minStarRating => 3})

    # SFO Airport
    response2 = api.get_list({:latitude => "37.625732", :longitude => "-122.377807", 
      :sort => "PROXIMITY", :minStarRating => 3})

    @hotel_list = response.body['HotelListResponse']['HotelList']['HotelSummary']

    File.open("/Users/jayxni/Dropbox/jarvis/exechq/python/SJC.csv", 'w') do |csv|
      csv << "id,rating,proximity,latitude,longitude\n"
      @hotel_list.each do |hotel|
        csv << hotel["hotelId"].to_s + "," + hotel["hotelRating"].to_s + "," + 
          hotel["proximityDistance"].to_s + "," + hotel["latitude"].to_s + "," + hotel["longitude"].to_s
        csv << "\n"
      end
    end

    # Pass hotel list into hash
    # @hotel_hash = Hash.new
    # @hotel_list.each do |hotel|
    #   @hotel_hash[hotel["hotelId"]] = {:hotelId => hotel["hotelId"], :name => hotel["name"], 
    #     :address => hotel["address1"], :proximity => hotel["proximityDistance"], :rate => hotel["lowRate"]}
    # end


    @hotel_list2 = response2.body['HotelListResponse']['HotelList']['HotelSummary']

    File.open("/Users/jayxni/Dropbox/jarvis/exechq/python/SFO.csv", 'w') do |csv|
      csv << "id,rating,proximity,latitude,longitude\n"
      @hotel_list2.each do |hotel|
        csv << hotel["hotelId"].to_s + "," + hotel["hotelRating"].to_s + "," + 
          hotel["proximityDistance"].to_s + "," + hotel["latitude"].to_s + "," + hotel["longitude"].to_s
        csv << "\n"
      end
    end
=end
  end

  def search_itineraries
    api = Expedia::Api.new

    # Load SFO prices
    sfo_prices = SmarterCSV.process('/Users/jayxni/Dropbox/jarvis/exechq/python/SFO_prices.csv')
    @sfo_hash = Hash.new

    sfo_prices.each do |price|
      taxifare = (price[:lowprice].to_f + price[:highprice].to_f)/2.0
      @sfo_hash[price[:id]] = {:proximity => price[:proximity], :latitude => price[:latitude], :longitude => price[:longitude], :fare => taxifare}
    end

    # Load SJC prices
    sjc_prices = SmarterCSV.process('/Users/jayxni/Dropbox/jarvis/exechq/python/SJC_prices.csv')
    @sjc_hash = Hash.new

    sjc_prices.each do |price|
      taxifare = (price[:lowprice].to_f + price[:highprice].to_f)/2.0
      @sjc_hash[price[:id]] = {:proximity => price[:proximity], :latitude => price[:latitude], :longitude => price[:longitude], :fare => taxifare}
    end

    # Compute Expedia hotels
    @latitude = params[:latitude]
    @longitude = params[:longitude]

    response = api.get_list({:latitude => @latitude, :longitude => @longitude, 
      :sort => "PROXIMITY", :minStarRating => 3})

    @api_list = response.body['HotelListResponse']['HotelList']['HotelSummary']
    @hotel_list = Array.new
    @rejected = 0

    @api_list.each do |hotel|
      valid = true

      entry = {:hotelId => hotel["hotelId"], :name => hotel["name"], :rating => hotel["hotelRating"].to_i,
        :latitude => hotel["latitude"], :longitude => hotel["longitude"],
        :address => hotel["address1"], :proximity => hotel["proximityDistance"], :rate => hotel["lowRate"],
        :sfo_distance => 999, :sjc_distance => 999, :sfo_fare => 999, :sjc_fare => 999}
      
      # is SJC or SFO closer?
      sfo_info = @sfo_hash[entry[:hotelId]]
      unless sfo_info.nil? 
        entry[:sfo_distance] = sfo_info[:proximity]
        entry[:sfo_fare] = sfo_info[:fare]
      end
      sjc_info = @sjc_hash[entry[:hotelId]]
      unless sjc_info.nil?
        entry[:sjc_distance] = sjc_info[:proximity]
        entry[:sjc_fare] = sjc_info[:fare]
      end

      if entry[:sfo_fare] < entry[:sjc_fare]
        entry[:airport] = "SFO"
        entry[:travelcost] = entry[:sfo_fare]
      else
        entry[:airport] = "SJC"
        entry[:travelcost] = entry[:sjc_fare]
      end

      # Validity Checks
      if entry[:sfo_distance] == 999 and entry[:sjc_distance] == 999
        valid = false
      end

      if entry[:rate] < 1
        valid = false
      end

      if valid
        @hotel_list << entry
      else
        @rejected = @rejected + 1
      end
    end

    respond_to do |format|
      format.js
    end
  end
end
