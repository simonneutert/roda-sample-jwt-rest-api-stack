class App
  plugin :hash_routes

  hash_routes('/api/v1').on 'items' do |r|
    items_repo = ItemRepository.new.repository

    r.is Integer do |id|
      items_repo.where(id:)
                .all
                .first
    end

    r.on do
      items_repo.limit(1000)
                .all
    end
  end
end
