class App
  plugin :hash_routes

  hash_routes('/api/v1').on 'items' do |r|
    r.is Integer do |item_id|
      ItemRepository.new
                    .repository
                    .where(id: item_id)
                    .all
                    .first
    end

    r.on do
      ItemRepository.new
                    .all
    end
  end
end
