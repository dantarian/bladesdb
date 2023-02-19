class ChangeDeclarationsFromDateTimesToDates < ActiveRecord::Migration[4.2]
  def self.up
    change_table :character_point_adjustments do |t|
      t.remove :declared_at
      t.date :declared_on
    end
    
    change_table :death_threshold_adjustments do |t|
      t.remove :declared_at
      t.date :declared_on
    end
    
    change_table :monster_point_adjustments do |t|
      t.remove :declared_at
      t.date :declared_on
    end
    
    change_table :monster_point_declarations do |t|
      t.remove :declared_at
      t.date :declared_on
    end
  end

  def self.down
    raise IrreversibleMigration, "Non-nullable columns removed during migration."
  end
end
