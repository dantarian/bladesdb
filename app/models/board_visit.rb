class BoardVisit < ApplicationRecord
    belongs_to :board
    belongs_to :user
  
    validates_presence_of :board_id
    validates_presence_of :user_id
    validates_presence_of :last_visit
    
    validates_uniqueness_of :user_id, :scope => :board_id
end
