Given(/^I am not logged in$/) do
  page.find("div#sessionpanel").should have_content("Not logged in")
end

When(/^I(?:| have| am) log(?:|ged) in$/) do
  log_in
end

When(/^I(?:| have| am) log(?:|ged) in as an? (.*?) user$/) do |state|
  log_in(state)
end

Given(/^I have registered$/) do
  @user = create_user
end

Given(/^I have registered with "(.*?)"$/) do |email|
  @user = create_user email: email
end

Given(/^I have not confirmed my e\-mail address$/) do
  # Nothing to do.
end

Given(/^I have confirmed my account$/) do
    confirm_user(@user)
end

Given(/^I have not been approved$/) do
  # Empty step.
end

Given(/^I have been approved$/) do
    approve_user(@user)
end

Given(/^(I am|they are?) an? "(.*?)" user$/) do |actor,rolename|
  rolename.downcase!
  if actor == "I am"
    @user = create_user(state: :approved) if @user.nil?
    @user.roles << Role.find_by(rolename: rolename)
  else
    @other_user = create_user(state: :approved) if @other_user.nil?
    @other_user.roles << Role.find_by(rolename: rolename)
  end
end

Given(/^(I am|they are?) a user who is (.*?)$/) do |actor, state|
  state.downcase!
  if actor == "I am"
    @user = create_user(state: state.to_sym) if @user.nil?
  else
    @other_user = create_user(state: state.to_sym) if @other_user.nil?
  end
end

Given(/^there is another user$/) do
  @other_user = create_user(username: "testuser2", name: "Test User2", email: "test2@mail.com", state: :approved)
end

When(/^I go to the list users page$/) do
  visit users_path
end

Given(/^(my|their?) name is "(.*?)"$/) do |actor, value|
  if actor == "my"
    @user.name = value
    @user.save
  else
    @other_user.name = value
    @other_user.save
  end
end

Given(/^(my|their?) login is "(.*?)"$/) do |actor, value|
  if actor == "my"
    @user.username = value
    @user.save
  else
    @other_user.username = value
    @other_user.save
  end
end

Given(/^(my|their?) email is "(.*?)"$/) do |actor, value|
  if actor == "my"
    @user.email = value
    @user.save
  else
    @other_user.email = value
    @other_user.save
  end
end

Given(/^(my|their?) password is "(.*?)"$/) do |actor, value|
  if actor == "my"
    @user.password = value
    @user.save
  else
    @other_user.password = value
    @other_user.save
  end
end

Given(/^(my|their?) mobile number is "(.*?)"$/) do |actor, value|
  if actor == "my"
    @user.mobile_number = value
    @user.save
  else
    @other_user.mobile_number = value
    @other_user.save
  end
end

Given(/^(my|their?) contact name is "(.*?)"$/) do |actor, value|
  if actor == "my"
    @user.contact_name = value
    @user.save
  else
    @other_user.contact_name = value
    @other_user.save
  end
end

Given(/^(my|their?) contact number is "(.*?)"$/) do |actor, value|
  if actor == "my"
    @user.contact_number = value
    @user.save
  else
    @other_user.contact_number = value
    @other_user.save
  end
end

Given(/^(my|their?) food notes are "(.*?)"$/) do |actor, value|
  if actor == "my"
    @user.food_notes = value
    @user.save
  else
    @other_user.food_notes = value
    @other_user.save
  end
end

Given(/^(my|their?) medical notes are "(.*?)"$/) do |actor, value|
  if actor == "my"
    @user.medical_notes = value
    @user.save
  else
    @other_user.medical_notes = value
    @other_user.save
  end
end

Given(/^(my|their?) general notes are "(.*?)"$/) do |actor, value|
  if actor == "my"
    @user.notes = value
    @user.save
  else
    @other_user.notes = value
    @other_user.save
  end
end

Given(/^I have never updated my emergency details$/) do
  # Do nothing.
end

Given(/^I last updated my emergency details "(.*?)"$/) do |updated|
  if updated == "yesterday"
    @user.emergency_last_updated = Date.today - 1.day
  elsif updated == "four months ago"
    @user.emergency_last_updated = Date.today - 4.months
  end
end

Given(/^they are suspended$/) do
  @other_user.suspend!
end

Given(/^they are deleted/) do
  @other_user.delete!
end

Given(/^there is an unconfirmed user$/) do
  @other_user = create_user(username: "testuser2", name: "Test User2", email: "test2@mail.com", state: :pending)
end

Given(/^there is a pending user$/) do
  @other_user = create_user(username: "testuser2", name: "Test User2", email: "test2@mail.com", state: :confirmed)
end

def create_user(opts = {})
  user = User.new(username: opts[:username] || "testuser", name: opts[:name] || "Test User", email: opts[:email] || "test@mail.com", password: opts[:password] || "Passw0rd", password_confirmation: opts[:password_confirmation] || opts[:password] || "Passw0rd")
  user.save
  if (opts[:state] == :confirmed) || (opts[:state] == :approved) || (opts[:state] == :suspended)
    confirm_user(user)
    if (opts[:state] == :approved) || (opts[:state] == :suspended)
      approve_user(user)
      if (opts[:state] == :suspended)
        suspend_user(user)
      end
    end
  end
  user
end

def confirm_user(user)
  user.confirmed_at = Time.now
  user.activate
  user.save
  user
end

def approve_user(user)
  user.approve
  user.save
  user
end

def suspend_user(user)
  user.suspend
  user.save
  user
end

def log_in(state = :approved)
  @user = create_user(state: state) if @user.nil?
  visit new_user_session_path
  fill_in "Username", with: @user.username
  fill_in "Password", with: @user.password
  click_button "Sign in"
end
