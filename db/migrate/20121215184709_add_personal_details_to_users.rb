class AddPersonalDetailsToUsers < ActiveRecord::Migration[4.2]
  def self.up
    change_table :users do |t|
      t.string :contact_name, :null => true
      t.string :contact_number, :null => true
      t.string :medical_notes, :null => true
      t.string :notes, :null => true
    end
  end

  def self.down
    change_table :users do |t|
            t.remove :contact_name,
                     :contact_number,
                     :medical_notes,
                     :notes
            end
  end
end
