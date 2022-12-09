# frozen_string_literal: true

class App
  plugin :hash_routes

  hash_routes('/api/v1').on 'download' do |r|
    r.on do
      # relative to root of the app!
      send_file './Dockerfile'
    end
  end
end
