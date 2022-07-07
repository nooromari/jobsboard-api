# frozen_string_literal: true

class CreateApplications < ActiveRecord::Migration[7.0]
  def change
    create_table :applications do |t|
      t.boolean :seen, default: false
      t.references :user, null: false, foreign_key: true
      t.references :job, null: false, foreign_key: true

      t.timestamps
    end
  end
end
