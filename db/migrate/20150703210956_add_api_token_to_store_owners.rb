class AddApiTokenToStoreOwners < ActiveRecord::Migration
  def change
    add_column :store_owners, :api_token, :string
    add_index(:store_owners, :api_token, unique: true)
  end
end
