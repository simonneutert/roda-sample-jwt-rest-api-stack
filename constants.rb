# frozen_string_literal: true

DB_CONNECTION = 'sqlite://backend.db'
DB = Sequel.connect(DB_CONNECTION)

SECRET = 'my$ecretK3y'
