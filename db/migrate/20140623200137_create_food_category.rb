class CreateFoodCategory < ActiveRecord::Migration[4.2]
  def change
    create_table :food_categories do |t|
      t.string :description, null: false
    end
  end
end
