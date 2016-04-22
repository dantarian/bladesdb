module CharacterTestHelper
  module_function # Ensure that all subsequent methods are available as Module Functions
  
  def create_character(user, name: "Testy McTesterson", race: Race.first, starting_points: 20, starting_florins: 0, starting_death_thresholds: 10, state: "active")
      character = user.characters.create_with(race: race, starting_points: starting_points, starting_florins: starting_florins, starting_death_thresholds: starting_death_thresholds, state: state).find_or_create_by!(name: name)
      guild_membership = character.guild_memberships.build
      guild_membership.character = character
      guild_membership.start_points = 0
      guild_membership.declared_on = character.declared_on
      guild_membership.provisional = false
      guild_membership.approved = true
      character.save
  end
  
  def set_starting_points(character, points)
      character.starting_points = points
      character.save
  end
  
  def approve_character(character, user)
      character.approve(user)
      character.save
  end
  
  def approve_character(user)
      character = Character.first
      character.approve(user)
      character.save
  end
  
  def retire_character
      Character.first.retire
  end
  
  def permdeath_character
      
  end
  
  # Validations
  
  def check_character_has_character_points(character: Character.first, points: 0)
    character.points.should eq points
  end
end
