class CreateAcceptables < ActiveRecord::Migration[4.2]
  def change
    create_table :acceptables do |t|
      t.string :flavour, null: false
      t.text :text, null: false

      t.timestamps
    end
  end
end
