class JwtService
  def initialize
    @hmac_secret = SECRET.dup
  end

  def encode(payload)
    # The secret must be a string. A JWT::DecodeError will be raised if it isn't provided.
    stamp_current_time!(payload)
    expire_in_hours!(payload, 1)

    JWT.encode(payload, @hmac_secret, 'HS256')
  end

  def decode(token)
    raise ArgumentError unless token.split(' ').size == 2

    JWT.decode(token.split(' ').last, @hmac_secret, true, { algorithm: 'HS256' })
  end

  private

  def stamp_current_time!(payload)
    payload.merge!(time: Time.now.to_f)
  end

  def expire_in_hours!(payload, hours_until_expiration = 1)
    minutes = hours_to_minutes(hours_until_expiration)
    payload.merge!(exp: time_now_in_future(minutes_in_future: minutes))
  end

  def expire_in_minutes!(payload, minutes_until_expiration = 1)
    payload.merge!(exp: time_now_in_future(minutes_in_future: minutes_until_expiration))
  end

  def time_now_in_future(minutes_in_future:)
    Time.now.to_i + minutes_to_seconds(minutes_in_future)
  end

  def minutes_to_seconds(minutes = 1)
    minutes * 60
  end

  def hours_to_minutes(hours = 1)
    hours * 60
  end

  def hours_to_seconds(hours = 1)
    minutes_to_seconds(hours_to_minutes(hours))
  end
end
