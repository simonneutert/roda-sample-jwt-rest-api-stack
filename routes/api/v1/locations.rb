class App
  plugin :hash_routes

  hash_routes('/api/v1').on 'locations' do |r|
    r.get do
      locations = LocationRepository.new
      results = locations.for_user(@current_user, 100)
      { locations: results }
    end

    r.post do
      locations = LocationRepository.new
      persisting = locations.save!(@current_user, r.params)
      unless persisting[:status] == :success
        response.status = persisting[:status] || 500
        next
      end
    end
  end
end
