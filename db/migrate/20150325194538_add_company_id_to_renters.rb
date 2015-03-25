class AddCompanyIdToRenters < ActiveRecord::Migration
  def change
    add_column :renters, :company_id, :integer
  end
end
