class LocationRepository
  attr_reader :repository

  def initialize
    @repository = DB.from(:locations)
  end

  def save!(current_user, data)
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
end
