class App
  plugin :hash_routes

  def auth_jwt(request:)
    @current_user = JwtAuthService.new(request.headers).auth!
  rescue StandardError => e
    response.status = 401
  end

  hash_branch('api') do |r|
    r.on 'v1' do
      r.post 'auth' do
        AuthServiceV1.new(r.params.slice('email', 'password')).auth!
      end

      # auth everything else
      response_error_status = response.status && response.status >= 400
      next if !!auth_jwt(request: r) && response_error_status

      r.hash_routes('/api/v1')
    end

    # r.on 'v2' do
    #   r.post 'auth' do
    #     # AuthServiceV2.new(r.params.slice('email', 'password')).auth!
    #   end

    #   # auth everything else
    #   next if !!auth_jwt(request: r) && response.status && response.status >= 400

    #   r.hash_routes('/api/v2')
    # end
  end
end
