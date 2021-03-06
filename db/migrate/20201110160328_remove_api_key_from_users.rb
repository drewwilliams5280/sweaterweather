# frozen_string_literal: true

class RemoveApiKeyFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :api_key, :string
  end
end
