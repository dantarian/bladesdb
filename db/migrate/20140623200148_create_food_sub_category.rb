class CreateFoodSubCategory < ActiveRecord::Migration
  def change
    create_table :food_sub_categories do |t|
      t.string :description, null: false
    end
  end
end
