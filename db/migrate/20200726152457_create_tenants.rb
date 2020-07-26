class CreateTenants < ActiveRecord::Migration[6.0]
  def change
    create_table :tenants do |t|
      t.references :tenant, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
    add_index :tenants, :name
  end
end
