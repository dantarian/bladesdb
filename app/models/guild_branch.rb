class GuildBranch < ApplicationRecord
    belongs_to :guild
    has_many :characters

    validates_presence_of :name
    validates_presence_of :guild_id
end
