class AddFoodCategoryAndSubCategoryToFoodOptions < ActiveRecord::Migration
  def change
    add_reference :food_options, :food_category, index: true
    add_reference :food_options, :food_sub_category, index: true
  end
end
