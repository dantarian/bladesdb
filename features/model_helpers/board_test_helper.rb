module BoardTestHelper
  module_function # Ensure that all subsequent methods are available as Module Functions
  
  def create_board(id: nil, name: nil)
    if id
      Board.find_or_create_by(id: id, name: name || "New Board", order: 1)
    else
      Board.find_or_create_by(name: name || "New Board", order: 1)
    end
  end
  
  def make_ic_board(board)
    
  end
  
  def create_message(board, user, character: nil, name: nil, message: "Test", request_uuid: SecureRandom.uuid)
    if character
      board.messages.create_with(character_id: character.id, request_uuid: request_uuid, message: message).find_or_create_by(user_id: user.id)
    elsif name
      board.messages.create_with(name: name, request_uuid: request_uuid, message: message).find_or_create_by(user_id: user.id)
    else
      board.messages.create_with(request_uuid: request_uuid, message: message).find_or_create_by(user_id: user.id)
    end  
  end
  
end
