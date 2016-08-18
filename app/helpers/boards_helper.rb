module BoardsHelper

  def number_of_messages(board)
    case
    when board.nil?
      logger.warn("[BoardsHelper#number_of_messages] board is nil")
      0
    when board.messages.nil?
      logger.warn("[BoardsHelper#number_of_messages] board.messages is nil")      
      0
    when board.messages.respond_to(:size) then board.messages.size
    else 
      logger.warn("[BoardsHelper#number_of_messages] board.messages does not respond to size()")
      0
    end
  end

end
