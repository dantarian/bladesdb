module MonsterPointSpendTestHelper
  module_function
  
  def create_monster_point_spend(character, date: Date.today, character_points_gained: 1, monster_points_spent: 1)
      monster_point_spend = MonsterPointSpend.new(character: character, spent_on: date, character_points_gained: character_points_gained, monster_points_spent: monster_points_spent)
      monster_point_spend.save!
  end
end