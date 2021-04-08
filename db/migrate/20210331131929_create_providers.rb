# frozen_string_literal: true

class CreateProviders < ActiveRecord::Migration[6.1]
  def change
    create_table :providers do |t|
      t.string :provider_name
      t.string :provider_uid
      t.integer :user_id
      t.timestamps
    end
  end
end
