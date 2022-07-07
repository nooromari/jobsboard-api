# frozen_string_literal: true

class AddUserTypeToUsers < ActiveRecord::Migration[7.0]
  def up
    add_column :users, :is_admin, :boolean, default: false
  end

  def down
    remove_column :users, :is_admin, :boolean, default: false
  end
end
