# frozen_string_literal: true

require 'pry' unless ENV.fetch('RACK_ENV') == 'production'

require 'roda'
require 'sequel'
require 'jwt'
require 'bcrypt'

require_relative 'constants'
require_relative 'db'

require 'rack/unreloader'
Unreloader = Rack::Unreloader.new(subclasses: %w[Roda Sequel::Model]) { App }
Unreloader.require './app.rb'
Dir['lib/**/*.rb'].each do |lib_file|
    Unreloader.require lib_file
  end
  
  Dir['db/repositories/**/*.rb'].each do |repo_file|
    Unreloader.require repo_file
  end
  
  Dir['routes/**/*.rb'].each do |route_file|
    Unreloader.require route_file
  end

run Unreloader
