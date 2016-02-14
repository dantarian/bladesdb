module BoardTestHelper
  module_function # Ensure that all subsequent methods are available as Module Functions
  
  def create_board(opts = {})
    board = nil
    if opts[:id]
      board = Board.new(id: opts[:id],
                        title: opts[:title] || "New Board")
    else
      board = Board.new(title: opts[:title] || "New Board")
    end
    board.save
    board
  end
end
