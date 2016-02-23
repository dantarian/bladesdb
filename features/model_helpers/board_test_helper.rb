module BoardTestHelper
  module_function # Ensure that all subsequent methods are available as Module Functions
  
  def create_board(id: nil, name: nil)
    if id
      Board.find_or_create_by(id: id, name: name || "New Board", order: 1)
    else
      Board.find_or_create_by(name: name || "New Board", order: 1)
    end
  end
end
