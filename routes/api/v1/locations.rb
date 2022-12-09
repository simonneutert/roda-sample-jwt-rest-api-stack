# frozen_string_literal: true

class App
  plugin :hash_routes

  hash_routes('/api/v1').on 'locations' do |r|
    r.get do
      locations = LocationRepository.new
      results = locations.for_user(@current_user)
      { locations: results }
    end

    r.post do
      locations = LocationRepository.new
      result = locations.save!(@current_user, r.params)
      unless result[:status] == :success
        response.status = result[:status] || 500
        next
      end
      result
    end
  end
end
