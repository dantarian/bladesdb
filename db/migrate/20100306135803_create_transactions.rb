class CreateTransactions < ActiveRecord::Migration[4.2]
    def self.up
        create_table :transactions do |t|
            t.date :transaction_date, :null => false
            t.integer :value, :null => false
            t.string :description, :null => false
            t.integer :illegality, :null => false, :default => 0
            t.boolean :taxed, :null => false, :default => true
            t.datetime :approved_at, :null => true
            t.references :approved_by, :null => true
            t.boolean :approved, :null => true

            t.timestamps
        end
    end

    def self.down
        drop_table :transactions
    end
end
