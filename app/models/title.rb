class Title < ActiveRecord::Base
    belongs_to :guild

    validates_presence_of :name
    validates_presence_of :guild_id
    validates_presence_of :points
    validates_numericality_of :points, :only_integer => true, :greater_than_or_equal_to => 0
end
