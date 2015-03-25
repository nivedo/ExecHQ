class AddCompanyToRenters < ActiveRecord::Migration
  def change
    add_column :renters, :company_name, :string
  end
end
