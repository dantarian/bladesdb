class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table "users", :force => true do |t|
      t.column :login,                     :string, :limit => 40, :null => false
      t.column :name,                      :string, :limit => 100, :default => '', :null => false
      t.column :email,                     :string, :limit => 100, :null => true
      t.column :crypted_password,          :string, :limit => 40, :null => true
      t.column :salt,                      :string, :limit => 40
      t.column :created_at,                :datetime
      t.column :updated_at,                :datetime
      t.column :remember_token,            :string, :limit => 40
      t.column :remember_token_expires_at, :datetime
      t.column :activation_code,           :string, :limit => 40
      t.column :activated_at,              :datetime
      t.column :state,                     :string, :null => :no, :default => 'passive'
      t.column :approved_at,               :datetime
      t.column :deleted_at,                :datetime
    end
    add_index :users, :login, :unique => true
  end

  def self.down
    drop_table "users"
  end
end
