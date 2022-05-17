class ItemRepository < BaseRepository
  attr_reader :repository

  def initialize
    @repository = DB.from(:items)
  end

  def save!(data)
    @repository
      .multi_insert(
        data['items'].map do |d|
          { name: d['name'],
            longitude: d['price'] }
        end
      )
    { status: 200 }
  end

  def for_user(current_user)
    @repository
      .where(user_id: current_user[:id])
      .all
  end
end
