module GuildTestHelper
  module_function # Ensure that all subsequent methods are available as Module Functions
  
  def create_guild(name: "Test Guild", tithe_percentage: 0, proscribed: false)
    Guild.create_with(tithe_percentage: tithe_percentage, proscribed: proscribed).find_or_create_by!(name: name)
  end
  
  def create_guild_branch(name: "Branch 1", guild: Guild.last, title: "Pyromancer")
    GuildBranch.find_or_create_by!(name: name, guild_id: guild.id, branch_title: title)
  end
  
  def create_rank_title(guild, points, name)
    Title.create_with(points: points).find_or_create_by!(guild_id: guild.id, name: name)
  end
  
  def join_guild(character, guild = nil, guild_branch = nil, provisional: false, declared_on: Date.today, start_points: 0, approved: true)
    unless guild.nil?
      if guild_branch.nil?
        membership = GuildMembership.create_with(provisional: provisional, declared_on: declared_on, 
                                  start_points: start_points).find_or_create_by!(character_id: character.id, guild_id: guild.id)
      else
        membership = GuildMembership.create_with(provisional: provisional, declared_on: declared_on, 
                                  start_points: start_points).find_or_create_by!(character_id: character.id, guild_id: guild.id, guild_branch_id: guild_branch.id)
      end
    else
      membership = GuildMembership.create_with(provisional: provisional, declared_on: declared_on, 
                                  start_points: start_points).find_or_create_by!(character_id: character.id, guild_id: nil)
    end
    
    unless approved.nil?
      membership.approved = approved
      membership.approved_at = Date.today
      membership.approved_by = User.first
      membership.save!
    end
  end
  
  def update_start_rank(start_points)
    membership = GuildMembership.last
    membership.start_points = start_points
    membership.save!
  end
  
  def leave_guild(character, declared_on: Date.today, start_points: 0, approved: true)
    membership = GuildMembership.create_with(provisional: false, declared_on: declared_on, 
                                start_points: start_points).find_or_create_by!(character_id: character.id, guild_id: nil)
  end
  
end