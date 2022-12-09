# frozen_string_literal: true

class App < Roda
  use Rack::Deflater # enables gzip

  plugin :json
  plugin :json_parser
  plugin :request_headers
  plugin :hash_routes
  plugin :all_verbs

  route do |r|
    # GET / request
    r.root do
      { healthcheck: :success }
    end

    r.hash_routes
  end
end
