class AddDescToProperties < ActiveRecord::Migration
  def change
    add_column :properties, :title, :string
    add_column :properties, :bedrooms, :integer
    add_column :properties, :bathrooms, :decimal, :precision => 2, :scale => 1
    add_column :properties, :accomodates, :integer
    add_column :properties, :hometype, :integer
  end
end
