# frozen_string_literal: true

class AuthError < StandardError
end

class AuthService
  def initialize(params)
    @email = params['email']
    @password = params['password']
  end

  def auth!
    user = user_db.find(email: @email).first
    raise AuthError unless user && validate_password(user)

    token = JwtService.new.encode({ user: user.except(:password, :jwt) })
    user_db.where(email: @email).update(jwt: token)

    { token: }
  end

  def jwt_auth!(headers); end

  private

  def validate_password(user)
    BCrypt::Password.new(user[:password]) == @password
  end

  def user_db
    DB.from(:demo_users)
  end
end
