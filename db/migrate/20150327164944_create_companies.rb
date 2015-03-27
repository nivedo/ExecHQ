class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.text :name
      t.text :mailing_address
      t.text :email

      t.timestamps null: false
    end
  end
end
