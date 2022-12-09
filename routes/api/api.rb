# frozen_string_literal: true

class App
  plugin :hash_routes

  @current_user = false

  def auth_jwt(request:)
    @current_user = JwtAuthService.new(request.headers).auth!
  rescue StandardError => e
    response.status = 401
  end

  def response_valid?(response, invalid_gte_status = 400)
    return true if response.empty?

    response.status && response.status < invalid_gte_status
  end

  hash_branch('api') do |r|
    r.on 'v1' do
      r.post 'auth' do
        AuthServiceV1.new(r.params.slice('email', 'password')).auth!
      end

      # auth everything else
      auth_jwt(request: r)
      next unless @current_user && response_valid?(response, 400)

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
