class DemoUserRepository
  attr_reader :repository

  def initialize
    @repository = DB.from(:demo_users)
  end

  def find_by_token(token)
    user = @repository.where(jwt: token).first
    sanitize(user) if user
  end

  def find_by_id(id)
    user = @repository.where(id:).first
    sanitize(user) if user
  end

  def find_by_email(email)
    user = @repository.where(email:).first
    sanitize(user) if user
  end

  private

  def sanitize(data)
    data.except(:password, :jwt, 'password', 'jwt')
  end
end
