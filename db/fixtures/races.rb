# db/fixtures/races.rb
# Character races

Race.seed( :name ) do |r|
    r.name = "Human"
    r.death_thresholds = 10
end

Race.seed( :name ) do |r|
    r.name = "Elf"
    r.death_thresholds = 3
end

Race.seed( :name ) do |r|
    r.name = "Half Elf"
    r.death_thresholds = 6
end

Race.seed( :name ) do |r|
    r.name = "Half Orc"
    r.death_thresholds = 7
end

Race.seed( :name ) do |r|
    r.name = "Half Ogre"
    r.death_thresholds = 7
end
