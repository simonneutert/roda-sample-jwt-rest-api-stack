class App
  plugin :hash_routes

  hash_routes('/api/v1').on 'healthcheck' do |r|
    r.on do
      { status: :success }
    end
  end
end
