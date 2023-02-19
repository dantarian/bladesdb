class CreateMessages < ActiveRecord::Migration[4.2]
  def self.up
    create_table :messages do |t|
      t.references :board, :null => false
      t.references :user, :null => false
      t.string :name, :null => true
      t.text :message, :null => false
      t.references :character, :null => true
      t.references :last_edited_by, :null => true
      t.boolean :deleted, :null => false, :default => false
      t.string :request_uuid, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :messages
  end
end
