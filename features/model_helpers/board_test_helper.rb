module BoardTestHelper
  module_function # Ensure that all subsequent methods are available as Module Functions
  
  def create_board(id: nil, name: "New OOC Board", closed: false, ic: false, order: 1)
    if id
      Board.create_with(closed: closed, order: order, in_character: ic).find_or_create_by!(id: id, name: name)
    else
      Board.create_with(closed: closed, order: order, in_character: ic).find_or_create_by!(name: name)
    end
  end
  
  def close_board(board)
    board.closed = true
    board.save!
  end
  
  def make_board_ic(board)
    board.in_character = true
    board.save!
  end
  
  def create_message(board, user, character: nil, name: nil, message: "Test", request_uuid: SecureRandom.uuid)
    if character
      board.messages.create_with(character_id: character.id, request_uuid: request_uuid, message: message).find_or_create_by!(user_id: user.id)
    elsif name
      board.messages.create_with(name: name, request_uuid: request_uuid, message: message).find_or_create_by!(user_id: user.id)
    else
      board.messages.create_with(request_uuid: request_uuid, message: message).find_or_create_by!(user_id: user.id)
    end  
  end
  
end
