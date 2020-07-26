class AddPlanToTenants < ActiveRecord::Migration[6.0]
  def change
    add_column :tenants, :plan, :string
  end
end
