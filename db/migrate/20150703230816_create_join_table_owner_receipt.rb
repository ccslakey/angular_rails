class CreateJoinTableOwnerReceipt < ActiveRecord::Migration
  def change
    create_join_table :store_owners, :simple_receipts do |t|
       t.index [:store_owner_id, :simple_receipt_id]
       t.index [:simple_receipt_id, :store_owner_id]
    end
  end
end
