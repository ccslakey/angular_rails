class AddApiTokenToStoreOwners < ActiveRecord::Migration
  def change
    add_column :stores, :api_token, :string
    add_index(:stores, :api_token, unique: true)
  end
end
