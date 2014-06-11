class RemoveComplicationsFromTransactions < ActiveRecord::Migration
  def self.up
    change_table :transactions do |t|
      t.remove :illegality, :taxed, :approved, :approved_by_id, :approved_at
    end
  end

  def self.down
    raise IrreversibleMigration, "Non-nullable columns removed during migration."
  end
end
