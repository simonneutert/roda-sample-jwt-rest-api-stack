# frozen_string_literal: true

def setup_demo
  # create an items table
  DB.create_table :items do
    primary_key :id
    String :name, unique: true, null: false
    Float :price, null: false
  end

  # create a dataset from the items table
  items = DB[:items]

  # populate the table
  items.insert(name: 'abc', price: rand * 100)
  items.insert(name: 'def', price: rand * 100)
  items.insert(name: 'ghi', price: rand * 100)

  DB.create_table :demo_users do
    primary_key :id
    String :email, unique: true, null: false
    String :password, null: false
    String :jwt, unique: true
  end

  demo_users = DB.from(:demo_users)
  password = BCrypt::Password.create('123')
  demo_users.insert(email: 'abc@test.test', password:)
rescue StandardError => e
  raise e unless e.to_s.include?('already exists')
end

setup_demo unless ENV.fetch('RACK_ENV') == 'production'
