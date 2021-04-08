# frozen_string_literal: true

class AddStripeIdToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :stripe_id, :string
  end
end
