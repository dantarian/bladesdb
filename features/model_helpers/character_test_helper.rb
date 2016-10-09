module CharacterTestHelper
  module_function # Ensure that all subsequent methods are available as Module Functions
  
  def create_character(user, name: "Testy McTesterson", race: Race.first, starting_points: 20, starting_florins: 0, starting_death_thresholds: 10, state: "active", title: "")
      user.characters.create_with(race: race, starting_points: starting_points, starting_florins: starting_florins, 
                                  starting_death_thresholds: starting_death_thresholds, state: state, title: title).find_or_create_by!(name: name)
  end
  
  def create_undeclared_character(user, name: "Testy McTesterson")
      user.characters.create_with(race: Race.find_by(name: "Human"), state: Character::Undeclared, starting_death_thresholds: 0).find_or_create_by!(name: name)
  end
  
  def approve_character(user = nil, character = nil)
      user ||= User.first
      character ||= Character.first
      character.approve(user)
      character.save
  end
  
  def update_starting_rank(points)
    character = Character.first
    character.starting_points = points
    character.save!
  end
  
  def add_character_point_adjustment(character, points, date = nil, approver = nil, approved: true)
    date = Date.today - 1.day if date.nil?
    approver = User.first
    cpa = CharacterPointAdjustment.new
    cpa.character = character
    cpa.declared_on = date
    cpa.points = points
    cpa.reason = "Test"
    if !approved.nil?
      cpa.approved = approved
      cpa.approved_at = date
      cpa.approved_by = approver
    end
    cpa.save!
  end
  
  def update_title(title)
    character = Character.first
    character.title = title
    character.save!
  end
  
  def set_no_title
    character = Character.first
    character.no_title = true
    character.save!
  end
  
end
