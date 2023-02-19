include EmailSpec::Helpers
include EmailSpec::Matchers

module EmailTestHelper
  module_function # Ensure that all subsequent methods are available as Module Functions
  
  def current_email_address
    # Replace with your  way to find your current email. e.g @current_user.email
    # last_email_address will return the last email address used by email spec to find an email.
    # Note that last_email_address will be reset after each Scenario.
    @user.email || last_email_address
  end
  
  def count_emails_with_subject(address, subject)
    ActionMailer::Base.deliveries
                      .select{ |m| m.to.include?(address) }
                      .select{ |m| m.subject =~ Regexp.new(Regexp.escape(subject)) }
                      .size
  end
  
  def open_email_with_subject(address, subject)
    open_email(address, :with_subject => subject)
  end
  
  def check_for_email(to: nil, regarding: nil)
    expect(count_emails_with_subject(to, "[BathLARP] #{regarding}")).to be > 0
  end
end
