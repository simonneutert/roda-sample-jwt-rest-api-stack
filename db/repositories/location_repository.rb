class LocationRepositoryError < StandardError
  attr_reader :error_data

  def initialize(error_data)
    super
    @error_data = error_data
  end
end

class LocationRepository < BaseRepository
  attr_reader :repository

  def initialize
    @repository = DB.from(:locations)
  end

  def save!(current_user, data)
    result(200, 400) do
      validate_for_save!(current_user, data)
      @repository
        .multi_insert(
          data['locations'].map do |d|
            { latitude: d['latitude'],
              longitude: d['longitude'],
              user_id: current_user[:id] }
          end
        )
    end
  end

  def for_user(current_user)
    result(200, 400) do
      validate_current_user!(current_user)
      @repository
        .where(user_id: current_user[:id])
        .all
    end
  end

  private

  def validate_current_user!(current_user)
    raise LocationRepositoryError.new({ status: 401 }), 'current_user NOT present!' unless current_user
  end

  def validate_for_save!(current_user, data)
    validate_current_user!(current_user)
    raise LocationRepository.mew({ status: 400 }), 'data is NOT a Hash!' unless data.is_a?(Hash)

    unless data['locations'].is_a?(Array)
      raise LocationRepository.mew({ status: 400 }),
            "data['locations'] is NOT an Array!"
    end
  end
end
