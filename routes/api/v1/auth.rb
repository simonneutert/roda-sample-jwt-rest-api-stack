class App
  plugin :hash_routes

  hash_routes('/api/v1').on 'auth' do |r|
    r.on do
      { status: 200 }
    end

    r.post do
      AuthService.new(r.params.slice('email', 'password')).auth!
    end

    r.post 'decode' do
      JwtService.new.decode(r.headers['authorization'])
      { status: 200 }
    rescue StandardError
      { status: :fail }
    end
  end
end
