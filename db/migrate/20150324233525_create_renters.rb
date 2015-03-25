class CreateRenters < ActiveRecord::Migration
  def change
    create_table :renters do |t|
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :phone

      t.timestamps null: false
    end
  end
end
