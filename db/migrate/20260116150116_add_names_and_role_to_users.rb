class AddNamesAndRoleToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :first_name, :string, null: false
    add_column :users, :last_name, :string, null: false
    add_column :users, :role, :integer, default: 2, null: false
  end
end
