class BulkImportsController < ApplicationController
  before_action :authenticate_user!
  
  # GET /bulk_imports/new
  def new
  end
  
  # POST /bulk_imports/search
  def search
    @query = params[:query]
    @location = params[:location]
    
    if @query.blank? || @location.blank?
      flash.now[:alert] = "Please provide both a search query and location."
      render :new, status: :unprocessable_entity
      return
    end
    
    begin
      service = GooglePlacesService.new
      @results = service.text_search(query: @query, location: @location)
      
      if @results.empty?
        flash.now[:notice] = "No results found for '#{@query}' in '#{@location}'"
      end
      
      # Store search params in session for the import action
      session[:bulk_import_query] = @query
      session[:bulk_import_location] = @location
      
    rescue => e
      flash.now[:alert] = "Error searching Google Places: #{e.message}"
      @results = []
    end
    
    render :results
  end
  
  # POST /bulk_imports/import
  def import
    selected_place_ids = params[:place_ids] || []
    
    if selected_place_ids.empty?
      redirect_to new_bulk_import_path, alert: "No places were selected for import."
      return
    end
    
    imported_count = 0
    failed_count = 0
    errors = []
    
    service = GooglePlacesService.new
    
    selected_place_ids.each do |place_id|
      begin
        # Get detailed information for each selected place
        place_details = service.place_details(place_id)
        
        # Skip if business is permanently closed
        if place_details[:business_status] == 'CLOSED_PERMANENTLY'
          failed_count += 1
          errors << "#{place_details[:business_name]} is permanently closed"
          next
        end
        
        # Create lead with default values
        lead = current_user.leads.new(
          business_name: place_details[:business_name],
          location: place_details[:location],
          phone: place_details[:phone],
          website: place_details[:website],
          interest_level: :low,
          status: :interested,
          notes: "Imported from Google Places on #{Time.current.strftime('%m/%d/%Y')}"
        )
        
        if lead.save
          imported_count += 1
        else
          failed_count += 1
          errors << "#{place_details[:business_name]}: #{lead.errors.full_messages.join(', ')}"
        end
        
      rescue => e
        failed_count += 1
        errors << "Error importing place: #{e.message}"
      end
    end
    
    if imported_count > 0
      flash[:notice] = "Successfully imported #{imported_count} lead(s)."
    end
    
    if failed_count > 0
      flash[:alert] = "Failed to import #{failed_count} lead(s). #{errors.first(3).join('; ')}"
    end
    
    redirect_to leads_path
  end
  
  private
  
  def bulk_import_params
    params.permit(:query, :location, place_ids: [])
  end
end

