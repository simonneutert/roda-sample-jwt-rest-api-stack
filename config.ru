require 'rack/unreloader'
Unreloader = Rack::Unreloader.new(subclasses: %w[Roda]) { App }

Unreloader.require './app.rb'

run Unreloader
