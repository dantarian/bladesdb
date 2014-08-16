class CreateFoodCategory < ActiveRecord::Migration
  def change
    create_table :food_categories do |t|
      t.string :description, null: false
    end
  end
end
