class Guild < ApplicationRecord
    has_many :guild_branches
    has_many :titles
    has_many :characters

    validates_presence_of :name
    
    def calculate_title(points)
        title = titles.where("points <= ?", points).order(:points).last
        title ? title.name : ""
    end
    
    def has_branches?
        !guild_branches.empty?
    end
    
    def tax_rate
        (tithe_percentage || 0) / 100.0
    end
end
