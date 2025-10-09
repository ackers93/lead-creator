class GooglePlacesService
  BASE_URL = "https://maps.googleapis.com/maps/api/place"
  
  def initialize(api_key = nil)
    @api_key = api_key || ENV['GOOGLE_PLACES_API_KEY']
    raise "Google Places API key is not set" if @api_key.blank?
  end
  
  # Search for places based on query and location
  # @param query [String] e.g., "Plumbers"
  # @param location [String] e.g., "Camarillo, CA"
  # @return [Array<Hash>] Array of place results
  def text_search(query:, location:)
    search_query = "#{query} in #{location}"
    
    response = HTTP.get("#{BASE_URL}/textsearch/json", params: {
      query: search_query,
      key: @api_key
    })
    
    data = JSON.parse(response.body.to_s)
    
    if data['status'] == 'OK'
      data['results'].map { |place| format_place(place) }
    elsif data['status'] == 'ZERO_RESULTS'
      []
    else
      raise "Google Places API Error: #{data['status']} - #{data['error_message']}"
    end
  rescue HTTP::Error => e
    raise "HTTP Error: #{e.message}"
  end
  
  # Get detailed information about a place
  # @param place_id [String] Google Place ID
  # @return [Hash] Detailed place information
  def place_details(place_id)
    response = HTTP.get("#{BASE_URL}/details/json", params: {
      place_id: place_id,
      fields: 'name,formatted_address,formatted_phone_number,website,geometry,business_status',
      key: @api_key
    })
    
    data = JSON.parse(response.body.to_s)
    
    if data['status'] == 'OK'
      format_place_details(data['result'])
    else
      raise "Google Places API Error: #{data['status']}"
    end
  rescue HTTP::Error => e
    raise "HTTP Error: #{e.message}"
  end
  
  private
  
  # Format place data from text search
  def format_place(place)
    {
      place_id: place['place_id'],
      business_name: place['name'],
      location: place['formatted_address'] || place['vicinity'],
      latitude: place.dig('geometry', 'location', 'lat'),
      longitude: place.dig('geometry', 'location', 'lng'),
      business_status: place['business_status']
    }
  end
  
  # Format detailed place data
  def format_place_details(place)
    {
      business_name: place['name'],
      location: place['formatted_address'],
      phone: format_phone_number(place['formatted_phone_number']),
      website: place['website'],
      latitude: place.dig('geometry', 'location', 'lat'),
      longitude: place.dig('geometry', 'location', 'lng'),
      business_status: place['business_status']
    }
  end
  
  # Format phone number (remove extra characters)
  def format_phone_number(phone)
    return nil if phone.blank?
    # Keep only digits, spaces, hyphens, parentheses, and plus sign
    phone.gsub(/[^\d\s\-\+\(\)]/, '')
  end
end

