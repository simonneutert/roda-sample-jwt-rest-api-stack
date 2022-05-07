Sequel.migration do
  change do
    create_table(:locations) do
      foreign_key :user_id
      foreign_key :tour_id
      Float :latitude, null: false
      Float :longitude, null: false
      Float :accuracy
      String :timestamp
    end
  end
end
