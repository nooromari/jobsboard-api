class AddUserTypeToUsers < ActiveRecord::Migration[7.0]
  def up
    add_column :users, :user_type, :string
  end

  def down
    remove_column :users, :user_type
  end
end
