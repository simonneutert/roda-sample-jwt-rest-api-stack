class App
  plugin :hash_routes

  hash_routes('/api/v1').on 'locations' do |r|
    r.get do
      locations = LocationRepository.new
      locations.for_user(@current_user)
    end

    r.post do
      locations = LocationRepository.new
      locations.save!(@current_user, r.params)
    end
  end
end
