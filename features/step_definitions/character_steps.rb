Given(/^(I|they?) have a character$/) do |actor|
  if actor == "I"
    @character = create_character(user_id: @user.id)
  else
    @character = create_character(user_id: @other_user.id)
  end
  @character
end

Given(/^the character is a player on the game$/) do
  game_attendance = GameAttendance.new(game_id: @game.id, user_id: @character.user_id, character_id: @character.id, attend_state: GameAttendance::PLAYING, confirm_state: GameAttendance::REQUESTED)
  game_attendance.save
end

def create_character(opts = {})
  character = Character.new(user_id: opts[:user_id], name: opts[:name] || "Bob", race_id: opts[:race_id] || 1, starting_death_thresholds: opts[:starting_death_thresholds] || 10)
  character.save
  character
end