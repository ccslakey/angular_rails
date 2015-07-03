class CreateSimpleReceipts < ActiveRecord::Migration
  def change
    create_table :simple_receipts do |t|
      t.references :store_owner, index: true, foreign_key: true
      t.decimal :total
      t.decimal :amount
      t.decimal :tip
      t.string :transaction_num

      t.timestamps null: false
    end
  end
end
