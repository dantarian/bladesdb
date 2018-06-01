class CreateAcceptances < ActiveRecord::Migration
  def change
    create_table :acceptances do |t|
      t.references :acceptable, index: true
      t.references :user, index: true
      t.boolean :accepted

      t.timestamps
    end
  end
end
