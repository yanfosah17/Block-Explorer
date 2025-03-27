class CreateTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :transactions do |t|
      t.string :sender
      t.string :receiver
      t.decimal :deposit, precision: 20, scale: 10
      t.string :block_hash
      t.string :hash_key
      t.integer :height

      t.timestamps
    end

    add_index :transactions, :hash, unique: true
  end
end
