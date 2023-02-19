class CreatePages < ActiveRecord::Migration[4.2]
    def self.up
        create_table :pages do |t|
            t.string :title, :null => false, :limit => 50
            t.text :content, :null => false
            t.boolean :show_to_non_users, :null => false, :default => true
            t.timestamps
        end
    end

    def self.down
        drop_table :pages
    end
end
