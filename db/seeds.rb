# This file contains all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# Food Categories
FoodCategory.create(id: 1, description: "All") unless FoodCategory.exists?(1)
FoodCategory.create(id: 2, description: "Friday") unless FoodCategory.exists?(2)
FoodCategory.create(id: 3, description: "Saturday") unless FoodCategory.exists?(3)
FoodCategory.create(id: 4, description: "Sunday") unless FoodCategory.exists?(4)
FoodCategory.create(id: 5, description: "IC meal") unless FoodCategory.exists?(5)
FoodCategory.create(id: 6, description: "Other") unless FoodCategory.exists?(6)

# Food Sub-Categories
FoodSubCategory.create(id: 1, description: "Breakfast") unless FoodSubCategory.exists?(1)
FoodSubCategory.create(id: 2, description: "Lunch") unless FoodSubCategory.exists?(2)
FoodSubCategory.create(id: 3, description: "Dinner") unless FoodSubCategory.exists?(3)
FoodSubCategory.create(id: 4, description: "Snack") unless FoodSubCategory.exists?(4)
FoodSubCategory.create(id: 5, description: "Midnight snack") unless FoodSubCategory.exists?(5)
FoodSubCategory.create(id: 6, description: "Buffet") unless FoodSubCategory.exists?(6)
FoodSubCategory.create(id: 7, description: "Starter") unless FoodSubCategory.exists?(7)
FoodSubCategory.create(id: 8, description: "Main") unless FoodSubCategory.exists?(8)
FoodSubCategory.create(id: 9, description: "Dessert") unless FoodSubCategory.exists?(9)
FoodSubCategory.create(id: 10, description: "Other") unless FoodSubCategory.exists?(10)

# Guilds
[{id: 1, name: "Defenders", tithe_percentage: 0, proscribed: false},
 {id: 2, name: "Circle", tithe_percentage: 10, proscribed: false},
 {id: 3, name: "Towers", tithe_percentage: 10, proscribed: false},
 {id: 4, name: "Paladins", tithe_percentage: 10, proscribed: false},
 {id: 5, name: "Bladesingers", tithe_percentage: 10, proscribed: false},
 {id: 6, name: "Gladiators", tithe_percentage: 10, proscribed: false},
 {id: 7, name: "Temple of Balance", tithe_percentage: 10, proscribed: false},
 {id: 8, name: "Temple of Justice", tithe_percentage: 10, proscribed: false},
 {id: 9, name: "Temple of Order", tithe_percentage: 10, proscribed: false},
 {id: 10, name: "Temple of Might", tithe_percentage: 10, proscribed: false},
 {id: 11, name: "Temple of Freedom", tithe_percentage: 10, proscribed: false},
 {id: 12, name: "Temple of Life", tithe_percentage: 10, proscribed: false},
 {id: 13, name: "Humacti", tithe_percentage: 10, proscribed: false},
 {id: 14, name: "Illuminati", tithe_percentage: 10, proscribed: false},
 {id: 15, name: "Artificers", tithe_percentage: 10, proscribed: false},
 {id: 16, name: "Artisans", tithe_percentage: 20, proscribed: false},
 {id: 17, name: "Shadow Masters", tithe_percentage: 10, proscribed: true},
 {id: 18, name: "Temple of Death", tithe_percentage: 10, proscribed: true},
 {id: 19, name: "Temple of Chaos", tithe_percentage: 10, proscribed: true},
 {id: 20, name: "Temple of Anarchy", tithe_percentage: 10, proscribed: true},
 {id: 21, name: "Dark Blades", tithe_percentage: 10, proscribed: true},
 {id: 22, name: "Brethren", tithe_percentage: 20, proscribed: true},
 {id: 23, name: "Druids", tithe_percentage: 0, proscribed: false},
 {id: 24, name: "Amazons", tithe_percentage: 0, proscribed: false},
 {id: 25, name: "Barbarians", tithe_percentage: 0, proscribed: false},
 {id: 26, name: "Bounty Hunters", tithe_percentage: 0, proscribed: false}].each { |guild|
   g = Guild.find_or_initialize_by(id: guild[:id])
   g.name = guild[:name]
   g.tithe_percentage = guild[:tithe_percentage]
   g.proscribed = guild[:proscribed]
   g.save!
 }

# Guild Branches
[{id: 1, guild_id: 1, name: "Guards", branch_title: "Guard"},
 {id: 2, guild_id: 1, name: "Pathfinders", branch_title: "Pathfinder"},
 {id: 3, guild_id: 1, name: "Wardens", branch_title: "Warden"},
 {id: 4, guild_id: 1, name: "Archers", branch_title: "Archer"},
 {id: 5, guild_id: 3, name: "Air", branch_title: "Aeromancer"},
 {id: 6, guild_id: 3, name: "Earth", branch_title: "Geomancer"},
 {id: 7, guild_id: 3, name: "Fire", branch_title: "Pyromancer"},
 {id: 8, guild_id: 3, name: "Water", branch_title: "Hydromancer"},
 {id: 9, guild_id: 3, name: "General", branch_title: "Metamancer"},
 {id: 10, guild_id: 3, name: "Light", branch_title: "Photomancer"},
 {id: 11, guild_id: 3, name: "Spellsword", branch_title: "Spellsword"},
 {id: 12, guild_id: 3, name: "Dark", branch_title: "Nyxomancer"},
 {id: 13, guild_id: 16, name: "Weaponsmith", branch_title: "Journeyman"},
 {id: 14, guild_id: 16, name: "Armoursmith", branch_title: "Journeyman"},
 {id: 15, guild_id: 16, name: "Bowsmith", branch_title: "Journeyman"},
 {id: 16, guild_id: 16, name: "Leather-worker", branch_title: "Journeyman"},
 {id: 17, guild_id: 24, name: "Wildshaper", branch_title: "Wildshaper"},
 {id: 18, guild_id: 24, name: "Outrider", branch_title: "Outrider"},
 {id: 19, guild_id: 24, name: "Battlestrider", branch_title: "Battlestrider"},
 {id: 20, guild_id: 25, name: "Berserker", branch_title: "Berserker"},
 {id: 21, guild_id: 25, name: "Shaman", branch_title: "Shaman"},
 {id: 22, guild_id: 25, name: "Witchdoctor", branch_title: "Witchdoctor"}].each {|branch|
    gb = GuildBranch.find_or_initialize_by(id: branch[:id])
    gb.guild_id = branch[:guild_id]
    gb.name = branch[:name]
    gb.branch_title = branch[:branch_title]
    gb.save!
  }

# Pages
Page.create(id: 1, title: "Welcome to BLADES", show_to_non_users: true, content: "Under construction") unless Page.exists?(1)

# Races
[{id: 1, name: "Human", death_thresholds: 10},
 {id: 2, name: "Elf", death_thresholds: 3},
 {id: 3, name: "Half Elf", death_thresholds: 6},
 {id: 4, name: "Half Orc", death_thresholds: 7},
 {id: 5, name: "Half Ogre", death_thresholds: 7}].each{|race|
   r = Race.find_or_initialize_by(id: race[:id])
   r.name = race[:name]
   r.death_thresholds = race[:death_thresholds]
   r.save!
   }

# Roles
[{id: 1, rolename: "administrator", admin_only: true, system: true},
 {id: 2, rolename: "committee", admin_only: true, system: true},
 {id: 3, rolename: "characterref", admin_only: true, system: true},
 {id: 4, rolename: "firstaider", admin_only: false, system: true},
 {id: 5, rolename: "experiencedgm", admin_only: false, system: false},
 {id: 6, rolename: "insurance", admin_only: false, system: false},
 {id: 7, rolename: "webonly", admin_only: false, system: true}].each{|role|
   r = Role.find_or_initialize_by(id: role[:id])
   r.rolename = role[:rolename]
   r.admin_only = role[:admin_only]
   r.system = role[:system]
   r.save!
   }

# Sidebar Categories
unless SidebarCategory.exists?
  SidebarCategory.create(id: 1, name: "Administration", order: 1, show_for_non_users: false, show_for_admin_users_only: true, editable: false)
  SidebarCategory.create(id: 2, name: "Games and Events", order: 2, show_for_non_users: true, show_for_admin_users_only: false, editable: true, always_open: true)
  SidebarCategory.create(id: 3, name: "My Information", order: 3, show_for_non_users: false, show_for_admin_users_only: false, editable: true)
  SidebarCategory.create(id: 4, name: "About BathLARP", order: 4, show_for_non_users: true, show_for_admin_users_only: false, editable: true)
  SidebarCategory.create(id: 5, name: "About Tony LARP", order: 5, show_for_non_users: true, show_for_admin_users_only: false, editable: true)
  SidebarCategory.create(id: 6, name: "Message Boards", order: 7, show_for_non_users: false, show_for_admin_users_only: false, editable: false)
  SidebarCategory.create(id: 7, name: "Campaigns", order: 6, show_for_non_users: true, show_for_admin_users_only: false, editable: true)
  
  SidebarEntry.create(id: 1, name: "Manage Static Pages", order: 1, sidebar_category_id: 1, url: "/pages", editable: false)
  SidebarEntry.create(id: 2, name: "Manage Sidebar Contents", order: 2, sidebar_category_id: 1, url: "/sidebar/edit", editable: false)
  SidebarEntry.create(id: 3, name: "Manage Message Boards", order: 3, sidebar_category_id: 1, url: "/boards/admin", editable: false)
  SidebarEntry.create(id: 4, name: "Next Game", order: 1, sidebar_category_id: 2, url: "/next_game", editable: false)
  SidebarEntry.create(id: 5, name: "Event Calendar", order: 2, sidebar_category_id: 2, url: "/event_calendar", editable: false)
  SidebarEntry.create(id: 6, name: "Past Games", order: 3, sidebar_category_id: 2, url: "/games", editable: false)
  SidebarEntry.create(id: 7, name: "My Information", order: 1, sidebar_category_id: 3, url: "/user_profile", editable: false)
  SidebarEntry.create(id: 8, name: "My Monster Points", order: 2, sidebar_category_id: 3, url: "/monster_points", editable: false)
  SidebarEntry.create(id: 9, name: "All Members", order: 1, sidebar_category_id: 4, url: "/users", editable: false)
  SidebarEntry.create(id: 10, name: "All Characters", order: 1, sidebar_category_id: 5, url: "/characters", editable: false)
  SidebarEntry.create(id: 11, name: "List Message Boards", order: 1, sidebar_category_id: 7, url: "/boards", editable: false)
  SidebarEntry.create(id: 12, name: "Send Club Emails", order: 4, sidebar_category_id: 1, url: "/committee_contact/new", editable: false)
end

# Titles
[{id: 1, guild_id: 1, name: "BRANCH Lance Corporal", points: 100},
 {id: 2, guild_id: 1, name: "BRANCH Corporal", points: 200},
 {id: 3, guild_id: 1, name: "BRANCH Sergeant", points: 450},
 {id: 4, guild_id: 1, name: "BRANCH Lead Sergeant", points: 750},
 {id: 5, guild_id: 1, name: "BRANCH Master Sergeant", points: 1000},
 {id: 6, guild_id: 1, name: "BRANCH Sergeant Major", points: 1250},
 {id: 7, guild_id: 2, name: "Wizard", points: 0},
 {id: 8, guild_id: 2, name: "High Wizard", points: 200},
 {id: 9, guild_id: 2, name: "Arch Wizard", points: 500},
 {id: 10, guild_id: 3, name: "BRANCH", points: 0},
 {id: 11, guild_id: 3, name: "High BRANCH", points: 200},
 {id: 12, guild_id: 3, name: "Arch BRANCH", points: 500},
 {id: 13, guild_id: 4, name: "Paladin", points: 0},
 {id: 14, guild_id: 5, name: "Bladesinger", points: 0},
 {id: 15, guild_id: 6, name: "Gladiator", points: 0},
 {id: 16, guild_id: 6, name: "Champion", points: 150},
 {id: 17, guild_id: 7, name: "Guardian", points: 0},
 {id: 18, guild_id: 8, name: "Marshal", points: 0},
 {id: 19, guild_id: 9, name: "Judge", points: 0},
 {id: 20, guild_id: 10, name: "Master", points: 0},
 {id: 21, guild_id: 10, name: "High Master", points: 150},
 {id: 22, guild_id: 10, name: "Great Master", points: 450},
 {id: 23, guild_id: 10, name: "Grand Master", points: 900},
 {id: 24, guild_id: 11, name: "Seeker", points: 0},
 {id: 25, guild_id: 12, name: "Healer", points: 0},
 {id: 26, guild_id: 13, name: "Humacti", points: 0},
 {id: 27, guild_id: 15, name: "Artificer", points: 0},
 {id: 28, guild_id: 16, name: "Apprentice", points: 0},
 {id: 29, guild_id: 18, name: "Dark Brother", points: 0},
 {id: 30, guild_id: 23, name: "Acolyte", points: 0},
 {id: 31, guild_id: 23, name: "Druid", points: 100},
 {id: 32, guild_id: 23, name: "Hierophant", points: 1000},
 {id: 33, guild_id: 14, name: "Illuminati", points: 0},
 {id: 34, guild_id: 1, name: "BRANCH", points: 0},
 {id: 35, guild_id: 16, name: "BRANCH", points: 0},
 {id: 36, guild_id: 24, name: "BRANCH", points: 0},
 {id: 37, guild_id: 25, name: "BRANCH", points: 0},
 {id: 38, guild_id: 26, name: "Bounty Hunter", points: 0}].each{|title|
   t = Title.find_or_initialize_by(id: title[:id])
   t.guild_id = title[:guild_id]
   t.name = title[:name]
   t.points = title[:points]
   t.save!
   }

# Admin User
unless User.exists?(1)
  user = User.create(username: "admin", email: "test@test.com", name: "Admin User", password: "changeme", password_confirmation: "changeme") 
  user.confirmed_at = Time.now
  user.activate
  user.save
  user.approve
  user.save
  Permission.create(id: 1, user_id: 1, role_id: 1) unless Permission.exists?(1)
end
