class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.integer :event_type
      t.datetime :start
      t.datetime :end
      t.integer :manager_id
      t.integer :property_id
      t.integer :renter_id

      t.timestamps null: false
    end
  end
end
