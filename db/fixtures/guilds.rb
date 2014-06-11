Guild.seed( :name ) do |guild|
    guild.name = "Defenders"
    guild.id = 1
    guild.tithe_percentage = 0
end

Title.seed( :name ) do |title|
    title.points = 100
    title.name = "Lance Corporal"
    title.guild_id = 1
end

Title.seed( :name ) do |title|
    title.points = 200
    title.name = "Corporal"
    title.guild_id = 1
end

Title.seed( :name ) do |title|
    title.points = 450
    title.name = "Sergeant"
    title.guild_id = 1
end

Title.seed( :name ) do |title|
    title.points = 750
    title.name = "Lead Sergeant"
    title.guild_id = 1
end

Title.seed( :name ) do |title|
    title.points = 1000
    title.name = "Master Sergeant"
    title.guild_id = 1
end

Title.seed( :name ) do |title|
    title.points = 1250
    title.name = "Sergeant Major"
    title.guild_id = 1
end

GuildBranch.seed( :name ) do |branch|
    branch.name = "Guards"
    branch.guild_id = 1
end

GuildBranch.seed( :name ) do |branch|
    branch.name = "Pathfinders"
    branch.guild_id = 1
end

GuildBranch.seed( :name ) do |branch|
    branch.name = "Wardens"
    branch.guild_id = 1
end

GuildBranch.seed( :name ) do |branch|
    branch.name = "Archers"
    branch.guild_id = 1
end

Guild.seed( :name ) do |guild|
    guild.name = "Circle"
    guild.tithe_percentage = 10
end

Title.seed( :name, :guild_id ) do |title|
    title.points = 0
    title.name = "Wizard"
    title.guild_id = 2
end

Title.seed( :name, :guild_id ) do |title|
    title.points = 200
    title.name = "High Wizard"
    title.guild_id = 2
end

Title.seed( :name, :guild_id ) do |title|
    title.points = 500
    title.name = "Arch Wizard"
    title.guild_id = 2
end

Guild.seed( :name ) do |guild|
    guild.name = "Towers"
    guild.tithe_percentage = 10
end

Title.seed( :name, :guild_id ) do |title|
    title.points = 0
    title.name = "Wizard"
    title.guild_id = 3
end

Title.seed( :name, :guild_id ) do |title|
    title.points = 200
    title.name = "High Wizard"
    title.guild_id = 3
end

Title.seed( :name, :guild_id ) do |title|
    title.points = 500
    title.name = "Arch Wizard"
    title.guild_id = 3
end

Guild.seed( :name ) do |guild|
    guild.name = "Paladins"
    guild.tithe_percentage = 10
end

Title.seed( :name ) do |title|
    title.points = 0
    title.name = "Paladin"
    title.guild_id = 4
end

Guild.seed( :name ) do |guild|
    guild.name = "Bladesingers"
    guild.tithe_percentage = 10
end

Title.seed( :name ) do |title|
    title.points = 0
    title.name = "Bladesinger"
    title.guild_id = 5
end

Guild.seed( :name ) do |guild|
    guild.name = "Gladiators"
    guild.tithe_percentage = 10
end

Title.seed( :name ) do |title|
    title.points = 0
    title.name = "Gladiator"
    title.guild_id = 6
end

Title.seed( :name ) do |title|
    title.points = 150
    title.name = "Champion"
    title.guild_id = 6
end

Guild.seed( :name ) do |guild|
    guild.name = "Temple of Balance"
    guild.tithe_percentage = 10
end

Title.seed( :name ) do |title|
    title.points = 0
    title.name = "Guardian"
    title.guild_id = 7
end

Guild.seed( :name ) do |guild|
    guild.name = "Temple of Justice"
    guild.tithe_percentage = 10
end

Title.seed( :name ) do |title|
    title.points = 0
    title.name = "Marshal"
    title.guild_id = 8
end

Guild.seed( :name ) do |guild|
    guild.name = "Temple of Order"
    guild.tithe_percentage = 10
end

Title.seed( :name ) do |title|
    title.points = 0
    title.name = "Judge"
    title.guild_id = 9
end

Guild.seed( :name ) do |guild|
    guild.name = "Temple of Might"
    guild.tithe_percentage = 10
end

Title.seed( :name ) do |title|
    title.points = 0
    title.name = "Master"
    title.guild_id = 10
end

Title.seed( :name ) do |title|
    title.points = 150
    title.name = "High Master"
    title.guild_id = 10
end

Title.seed( :name ) do |title|
    title.points = 450
    title.name = "Great Master"
    title.guild_id = 10
end

Title.seed( :name ) do |title|
    title.points = 900
    title.name = "Grand Master"
    title.guild_id = 10
end

Guild.seed( :name ) do |guild|
    guild.name = "Temple of Freedom"
    guild.tithe_percentage = 10
end

Title.seed( :name ) do |title|
    title.points = 0
    title.name = "Seeker"
    title.guild_id = 11
end

Guild.seed( :name ) do |guild|
    guild.name = "Temple of Life"
    guild.tithe_percentage = 10
end

Title.seed( :name ) do |title|
    title.points = 0
    title.name = "Healer"
    title.guild_id = 12
end

Guild.seed( :name ) do |guild|
    guild.name = "Humacti"
    guild.tithe_percentage = 10
end

Title.seed( :name ) do |title|
    title.points = 0
    title.name = "Humacti"
    title.guild_id = 13
end

Guild.seed( :name ) do |guild|
    guild.name = "Illuminati"
    guild.tithe_percentage = 10
end

Guild.seed( :name ) do |guild|
    guild.name = "Artificers"
    guild.tithe_percentage = 10
end

Title.seed( :name ) do |title|
    title.points = 0
    title.name = "Artificer"
    title.guild_id = 15
end

Guild.seed( :name ) do |guild|
    guild.name = "Artisans"
    guild.tithe_percentage = 20
end

Title.seed( :name ) do |title|
    title.points = 0
    title.name = "Apprentice"
    title.guild_id = 16
end

Guild.seed( :name ) do |guild|
    guild.name = "Shadow Masters"
    guild.tithe_percentage = 10
end

Guild.seed( :name ) do |guild|
    guild.name = "Temple of Death"
    guild.tithe_percentage = 10
end

Title.seed( :name ) do |title|
    title.points = 0
    title.name = "Dark Brother"
    title.guild_id = 18
end

Guild.seed( :name ) do |guild|
    guild.name = "Temple of Chaos"
    guild.tithe_percentage = 10
end

Guild.seed( :name ) do |guild|
    guild.name = "Temple of Anarchy"
    guild.tithe_percentage = 10
end

Guild.seed( :name ) do |guild|
    guild.name = "Dark Blades"
    guild.tithe_percentage = 10
end

Guild.seed( :name ) do |guild|
    guild.name = "Brethren"
    guild.tithe_percentage = 20
end

Guild.seed( :name ) do |guild|
    guild.name = "Druids"
    guild.tithe_percentage = 0
end

Guild.seed( :name ) do |guild|
    guild.name = "Amazons"
    guild.tithe_percentage = 0
end

Guild.seed( :name ) do |guild|
    guild.name = "Barbarians"
    guild.tithe_percentage = 0
end
