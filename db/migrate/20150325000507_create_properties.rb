class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.text :description
      t.string :location
      t.references :manager, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
