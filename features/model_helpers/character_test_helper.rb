module CharacterTestHelper
  module_function # Ensure that all subsequent methods are available as Module Functions
  
  def create_character(user, name: "Testy McTesterson", race: Race.first, starting_points: 20, starting_florins: 0, starting_death_thresholds: 10, state: "active")
      user.characters.create_with(race: race, starting_points: starting_points, starting_florins: starting_florins, starting_death_thresholds: starting_death_thresholds, state: state).find_or_create_by!(name: name)
  end
  
  def approve_character(user = nil, character = nil)
      user ||= User.first
      character ||= Character.first
      character.approve(user)
      character.save
  end
  
  def retire_character
      Character.first.retire
  end
  
  def permdeath_character
      
  end
  
end
