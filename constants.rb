DB_CONNECTION = 'sqlite://backend.db'.freeze
DB = Sequel.connect(DB_CONNECTION)

SECRET = 'my$ecretK3y'.freeze
