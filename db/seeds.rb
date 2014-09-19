# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

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
Guild.create(id: 1, name: "Defenders", tithe_percentage: 0) unless Guild.exists?(1)
Guild.create(id: 2, name: "Circle", tithe_percentage: 10) unless Guild.exists?(2)
Guild.create(id: 3, name: "Towers", tithe_percentage: 10) unless Guild.exists?(3)
Guild.create(id: 4, name: "Paladins", tithe_percentage: 10) unless Guild.exists?(4)
Guild.create(id: 5, name: "Bladesingers", tithe_percentage: 10) unless Guild.exists?(5)
Guild.create(id: 6, name: "Gladiators", tithe_percentage: 10) unless Guild.exists?(6)
Guild.create(id: 7, name: "Temple of Balance", tithe_percentage: 10) unless Guild.exists?(7)
Guild.create(id: 8, name: "Temple of Justice", tithe_percentage: 10) unless Guild.exists?(8)
Guild.create(id: 9, name: "Temple of Order", tithe_percentage: 10) unless Guild.exists?(9)
Guild.create(id: 10, name: "Temple of Might", tithe_percentage: 10) unless Guild.exists?(10)
Guild.create(id: 11, name: "Temple of Freedom", tithe_percentage: 10) unless Guild.exists?(11)
Guild.create(id: 12, name: "Temple of Life", tithe_percentage: 10) unless Guild.exists?(12)
Guild.create(id: 13, name: "Humacti", tithe_percentage: 10) unless Guild.exists?(13)
Guild.create(id: 14, name: "Illuminati", tithe_percentage: 10) unless Guild.exists?(14)
Guild.create(id: 15, name: "Artificers", tithe_percentage: 10) unless Guild.exists?(15)
Guild.create(id: 16, name: "Artisans", tithe_percentage: 20) unless Guild.exists?(16)
Guild.create(id: 17, name: "Shadow Masters", tithe_percentage: 10) unless Guild.exists?(17)
Guild.create(id: 18, name: "Temple of Death", tithe_percentage: 10) unless Guild.exists?(18)
Guild.create(id: 19, name: "Temple of Chaos", tithe_percentage: 10) unless Guild.exists?(19)
Guild.create(id: 20, name: "Temple of Anarchy", tithe_percentage: 10) unless Guild.exists?(20)
Guild.create(id: 21, name: "Dark Blades", tithe_percentage: 10) unless Guild.exists?(21)
Guild.create(id: 22, name: "Brethren", tithe_percentage: 20) unless Guild.exists?(22)
Guild.create(id: 23, name: "Druids", tithe_percentage: 0) unless Guild.exists?(23)
Guild.create(id: 24, name: "Amazons", tithe_percentage: 0) unless Guild.exists?(24)
Guild.create(id: 25, name: "Barbarians", tithe_percentage: 0) unless Guild.exists?(25)

# Guild Branches
GuildBranch.create(id: 1, guild_id: 1, name: "Guards") unless GuildBranch.exists?(1)
GuildBranch.create(id: 2, guild_id: 1, name: "Pathfinders") unless GuildBranch.exists?(2)
GuildBranch.create(id: 3, guild_id: 1, name: "Wardens") unless GuildBranch.exists?(3)
GuildBranch.create(id: 4, guild_id: 1, name: "Archers") unless GuildBranch.exists?(4)
# GuildBranch.create(id: 5, guild_id: 3, name: "Air") unless GuildBranch.exists?(5)
# GuildBranch.create(id: 6, guild_id: 3, name: "Earth") unless GuildBranch.exists?(6)
# GuildBranch.create(id: 7, guild_id: 3, name: "Fire") unless GuildBranch.exists?(7)
# GuildBranch.create(id: 8, guild_id: 3, name: "Water") unless GuildBranch.exists?(8)
# GuildBranch.create(id: 9, guild_id: 3, name: "General") unless GuildBranch.exists?(9)
# GuildBranch.create(id: 10, guild_id: 3, name: "Light") unless GuildBranch.exists?(10)
# GuildBranch.create(id: 11, guild_id: 3, name: "Spellsword") unless GuildBranch.exists?(11)
# GuildBranch.create(id: 12, guild_id: 3, name: "Dark") unless GuildBranch.exists?(12)
# GuildBranch.create(id: 13, guild_id: 16, name: "Weaponsmith") unless GuildBranch.exists?(13)
# GuildBranch.create(id: 14, guild_id: 16, name: "Armoursmith") unless GuildBranch.exists?(14)
# GuildBranch.create(id: 15, guild_id: 16, name: "Bowsmith") unless GuildBranch.exists?(15)
# GuildBranch.create(id: 16, guild_id: 16, name: "Leather-worker") unless GuildBranch.exists?(16)

# Pages
Page.create(id: 1, title: "Welcome to BLADES", show_to_non_users: true, content: "Under construction") unless Page.exists?(1)

# Races
Race.create(id: 1, name: "Human", death_thresholds: 10) unless Race.exists?(1)
Race.create(id: 2, name: "Elf", death_thresholds: 3) unless Race.exists?(2)
Race.create(id: 3, name: "Half Elf", death_thresholds: 6) unless Race.exists?(3)
Race.create(id: 4, name: "Half Orc", death_thresholds: 7) unless Race.exists?(4)
Race.create(id: 5, name: "Half Ogre", death_thresholds: 7) unless Race.exists?(5)

# Roles
Role.create(id: 1, rolename: "administrator") unless Role.exists?(1)
Role.create(id: 2, rolename: "committee") unless Role.exists?(2)
Role.create(id: 3, rolename: "characterref") unless Role.exists?(3)
Role.create(id: 4, rolename: "firstaider") unless Role.exists?(4)
Role.create(id: 5, rolename: "experiencedgm") unless Role.exists?(5)
Role.create(id: 6, rolename: "insurance") unless Role.exists?(6)
Role.create(id: 7, rolename: "webonly") unless Role.exists?(7)

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
end

# Titles
Title.create(id: 1, guild_id: 1, name: "Lance Corporal", points: 100) unless Title.exists?(1)
Title.create(id: 2, guild_id: 1, name: "Corporal", points: 200) unless Title.exists?(2)
Title.create(id: 3, guild_id: 1, name: "Sergeant", points: 450) unless Title.exists?(3)
Title.create(id: 4, guild_id: 1, name: "Lead Sergeant", points: 750) unless Title.exists?(4)
Title.create(id: 5, guild_id: 1, name: "Master Sergeant", points: 1000) unless Title.exists?(5)
Title.create(id: 6, guild_id: 1, name: "Sergeant Major", points: 1250) unless Title.exists?(6)
Title.create(id: 7, guild_id: 2, name: "Wizard", points: 0) unless Title.exists?(7)
Title.create(id: 8, guild_id: 2, name: "High Wizard", points: 200) unless Title.exists?(8)
Title.create(id: 9, guild_id: 2, name: "Arch Wizard", points: 500) unless Title.exists?(9)
Title.create(id: 10, guild_id: 3, name: "Wizard", points: 0) unless Title.exists?(10)
Title.create(id: 11, guild_id: 3, name: "High Wizard", points: 200) unless Title.exists?(11)
Title.create(id: 12, guild_id: 3, name: "Arch Wizard", points: 500) unless Title.exists?(12)
Title.create(id: 13, guild_id: 4, name: "Paladin", points: 0) unless Title.exists?(13)
Title.create(id: 14, guild_id: 5, name: "Bladesinger", points: 0) unless Title.exists?(14)
Title.create(id: 15, guild_id: 6, name: "Gladiator", points: 0) unless Title.exists?(15)
Title.create(id: 16, guild_id: 6, name: "Champion", points: 150) unless Title.exists?(16)
Title.create(id: 17, guild_id: 7, name: "Guardian", points: 0) unless Title.exists?(17)
Title.create(id: 18, guild_id: 8, name: "Marshal", points: 0) unless Title.exists?(18)
Title.create(id: 19, guild_id: 9, name: "Judge", points: 0) unless Title.exists?(19)
Title.create(id: 20, guild_id: 10, name: "Master", points: 0) unless Title.exists?(20)
Title.create(id: 21, guild_id: 10, name: "High Master", points: 150) unless Title.exists?(21)
Title.create(id: 22, guild_id: 10, name: "Great Master", points: 450) unless Title.exists?(22)
Title.create(id: 23, guild_id: 10, name: "Grand Master", points: 900) unless Title.exists?(23)
Title.create(id: 24, guild_id: 11, name: "Seeker", points: 0) unless Title.exists?(24)
Title.create(id: 25, guild_id: 12, name: "Healer", points: 0) unless Title.exists?(25)
Title.create(id: 26, guild_id: 13, name: "Humacti", points: 0) unless Title.exists?(26)
Title.create(id: 27, guild_id: 15, name: "Artificer", points: 0) unless Title.exists?(27)
Title.create(id: 28, guild_id: 16, name: "Apprentice", points: 0) unless Title.exists?(28)
Title.create(id: 29, guild_id: 18, name: "Dark Brother", points: 0) unless Title.exists?(29)
Title.create(id: 30, guild_id: 23, name: "Acolyte", points: 0) unless Title.exists?(30)
Title.create(id: 31, guild_id: 23, name: "Druid", points: 100) unless Title.exists?(31)
Title.create(id: 32, guild_id: 23, name: "Hierophant", points: 1000) unless Title.exists?(32)
Title.create(id: 33, guild_id: 14, name: "Illuminati", points: 0) unless Title.exists?(33)

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
