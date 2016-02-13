module UserTestHelper
  def create_user(opts = {})
    User.new(username: opts[:username] || "testuser",
             name: opts[:name] || "Test User", 
             email: opts[:email] || "test@mail.com", 
             password: opts[:password] || "Passw0rd", 
             password_confirmation: opts[:password_confirmation] || opts[:password] || "Passw0rd").save
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
end

