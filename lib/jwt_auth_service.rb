# frozen_string_literal: true

class JwtAuthService
  SINGLE_DEVICE_SIGNED_IN = false

  def initialize(headers)
    @headers = headers
    @bearer_token = headers['authorization']
    @token = @bearer_token.split(' ').last
  end

  #
  # returns the authed user or raises
  #
  # @return [User] User object
  #
  def auth!
    payload, _header = JwtService.new.decode(@bearer_token.dup)
    find_user(payload).except(:password, :jwt)
  end

  private

  def find_user(payload)
    user_repo = DemoUserRepository.new
    if SINGLE_DEVICE_SIGNED_IN
      raise unless @token

      user_repo.find_by_token(@token.dup)
    else
      email = payload.dig('user', 'email')
      raise unless email

      user_repo.find_by_email(email)
    end
  end
end
