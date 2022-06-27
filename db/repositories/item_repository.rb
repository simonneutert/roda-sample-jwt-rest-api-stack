class ItemRepository
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
    { status: :success }
  end

  def for_user(current_user, limit = 1000)
    q = @repository
        .where(user_id: current_user[:id])

    if limit > 0
      q.limit(limit).all
    else
      q.all
    end
  end
end
