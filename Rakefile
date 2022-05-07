require 'rake'
require 'sequel'
require_relative 'constants'

namespace :db do
  desc 'Run migrations'
  task :migrate, [:version] do |_t, args|
    require 'sequel/core'
    Sequel.extension :migration
    version = args[:version].to_i if args[:version]
    Sequel.connect(DB_CONNECTION) do |db|
      Sequel::Migrator.run(db, 'db/migrations', target: version)
    end
  end
end
