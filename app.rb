require 'pry' unless ENV.fetch('RACK_ENV') == 'production'

require 'roda'
require 'sequel'
require 'jwt'
require 'bcrypt'

require_relative 'constants'

require_relative 'db'

Dir['lib/**/*.rb'].each do |lib_file|
  Unreloader.require lib_file
end

Dir['db/repositories/**/*.rb'].each do |f|
  Unreloader.require f
end

class App < Roda
  use Rack::Deflater

  plugin :all_verbs
  plugin :json
  plugin :json_parser
  plugin :request_headers
  plugin :hash_routes

  Dir['routes/**/*.rb'].each do |route_file|
    Unreloader.require route_file
  end

  route do |r|
    # GET / request
    r.root do
      { healthcheck: :success }
    end

    r.hash_routes
  end
end
