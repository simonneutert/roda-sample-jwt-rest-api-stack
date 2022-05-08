class App
  plugin :hash_routes

  hash_routes('/api/v1').on 'locations' do |r|
    r.get do
      locations = LocationRepository.new
      result = locations.for_user(@current_user)
      response.status = result.status
      result.values
    end

    r.post do
      locations = LocationRepository.new
      response.status = locations.save!(@current_user, r.params).status
      r.halt
    end
  end
end
