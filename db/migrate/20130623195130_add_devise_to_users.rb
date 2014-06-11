class AddDeviseToUsers < ActiveRecord::Migration
  def self.up
    change_table(:users) do |t|
      ## Recoverable
      t.datetime :reset_password_sent_at

      ## Trackable
      t.integer  :sign_in_count, :default => 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

    end

    add_index :users, :email,                :unique => false
    add_index :users, :reset_password_token, :unique => true
    add_index :users, :confirmation_token,   :unique => true
  end

  def self.down
    remove_index :users, :email
    remove_index :users, :reset_password_token
    remove_index :users, :confirmation_token

    remove_column :users, :reset_password_sent_at
    remove_column :users, :sign_in_count
    remove_column :users, :current_sign_in_at
    remove_column :users, :last_sign_in_at
    remove_column :users, :current_sign_in_ip
    remove_column :users, :last_sign_in_ip
  end
end
