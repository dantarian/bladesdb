class CreateFoodChoices < ActiveRecord::Migration[4.2]
  def change
    create_table :food_choices do |t|
      t.references :food_options, index: true
      t.references :game_attendances, index: true
    end
  end
end
