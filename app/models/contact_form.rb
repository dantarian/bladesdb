class ContactForm < MailForm::Base
  attribute :from_user
  attribute :to_user
  attribute :bcc_list

  attribute :subject,   :validate => true
  attribute :message,   :validate => true

  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts. Using a body tag to make the template 
  # for the email work in a vaguely acceptable way.
  def headers
    {
      :subject => "#{subject}",
      :to => "#{to_user}",
      :from => "#{from_user}",
      :bcc => "#{bcc_list}",
      :body => "#{message}"
    }
  end
end