class CreateVenues < ActiveRecord::Migration[5.2]
  def change
    create_table :venues do |t|
      t.datetime :venue_date
      t.references :artist, foreign_key: true
      t.references :location, foreign_key: true

      t.timestamps
    end
  end
end
