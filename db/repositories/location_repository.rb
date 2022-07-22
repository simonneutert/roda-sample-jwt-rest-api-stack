class LocationRepositoryError < StandardError
  attr_reader :error_data

  def initialize(error_data)
    super
    @error_data = error_data
  end
end

class LocationRepository
  attr_reader :repository

  def initialize
    @repository = DB.from(:locations)
  end

  def save!(current_user, data)
    begin
      validate_for_save!(current_user, data)
    rescue LocationRepositoryError => e
      return { status: e.error_data[:status] }
    end

    @repository
      .multi_insert(
        data['locations'].map do |d|
          { latitude: d['latitude'],
            longitude: d['longitude'],
            user_id: current_user[:id] }
        end
      )
    { status: :success }
  end

  def for_user(current_user)
    @repository
      .where(user_id: current_user[:id])
      .all
  end

  private

  def validate_for_save!(current_user, data)
    raise LocationRepositoryError.new({ status: 401 }), 'current_user not present!' unless current_user
    raise LocationRepository.new({ status: 400 }), 'data is NOT a Hash!' unless data.is_a?(Hash)

    unless data['locations'].is_a?(Array)
      raise LocationRepository.new({ status: 400 }),
            "data['locations'] is NOT an Array!"
    end
  end
end
