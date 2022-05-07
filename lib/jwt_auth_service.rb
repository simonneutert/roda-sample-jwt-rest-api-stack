class JwtAuthService
  def initialize(headers)
    @headers = headers
    @bearer_token = headers['authorization']
    @token = @bearer_token.split(' ').last
  end

  def auth!
    payload, = JwtService.new.decode(@bearer_token.dup)
    user_db = DB.from(:demo_users)
    user = user_db.where(jwt: @token.dup).first
    user.except(:password, :jwt)
  end
end
