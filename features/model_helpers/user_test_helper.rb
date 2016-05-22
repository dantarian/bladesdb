module UserTestHelper
  module_function # Ensure that all subsequent methods are available as Module Functions
  
  DEFAULT_PASSWORD = "Passw0rd"

  def create_or_find_user(name: "Norman Normal", email: "norman@mail.com", username: "normaluser")
    user = User.create_with(name: name, email: email, password: DEFAULT_PASSWORD).find_or_create_by(username: username)
  end
  
  def create_or_find_another_user(name: "Ann Other", email: "another@mail.com", username: "anotheruser")
    user = User.create_with(name: name, email: email, password: DEFAULT_PASSWORD).find_or_create_by(username: username)
  end

  def make_admin(user)
    user.roles << Role.find_by(rolename: 'administrator')
    user.save
  end

  def confirm(user)
    user.confirmed_at = Time.now
    user.activate
    user.save
  end

  def approve(user)
    user.approve
    user.save
  end

  def suspend(user)
    user.suspend
    user.save
  end  
  
  def delete(user)
    user.delete
    user.save
  end  
  
  def grant_role(user, role)
    Permission.find_or_create_by(user: user, role: role)
  end
  
  def fill_in_all_details(user, mobile_number: "07777 888777", contact_name: "Bob Bobson", contact_number: "07888 777888", medical_notes: "Allergic to bees.", food_notes: "Intolerant to lactose.", notes: "Some notes.")
    updating_user = User.find_by(name: user.name)
    updating_user.updating = true
    updating_user.update!(mobile_number: mobile_number, contact_name: contact_name, contact_number: contact_number, medical_notes: medical_notes, food_notes: food_notes, notes: notes, emergency_last_updated: Date.today)
  end
  
  def add_monster_point_declaration(user, points, date = nil, approver = nil, approved: true)
    date = Date.today - 5.years if date.nil?
    approver = user if approver.nil?
    mpd = MonsterPointDeclaration.new
    mpd.user = user
    mpd.declared_on = date
    mpd.points = points
    if !approved.nil?
      mpd.approved = approved
      mpd.approved_at = date
      mpd.approved_by = approver
    end
    mpd.save!
  end
  
  def add_monster_point_adjustment(user, points, date = nil, approver = nil, approved: true)
    date = Date.today - 5.years if date.nil?
    approver = user if approver.nil?
    mpa = MonsterPointAdjustment.new
    mpa.user = user
    mpa.declared_on = date
    mpa.points = points
    mpa.reason = "Test"
    if !approved.nil?
      mpa.approved = approved
      mpa.approved_at = date
      mpa.approved_by = approver
    end
    mpa.save!
  end
end

