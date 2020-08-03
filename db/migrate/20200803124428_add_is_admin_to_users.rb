class AddIsAdminToUsers < ActiveRecord::Migration[6.0]
  # добавляем колонку Админ к User, которая по умолчанию будет false
  def change
    add_column :users, :is_admin, :boolean, default: false
  end
end
