class Mail::TestMailer
  mattr_accessor :shared_deliveries

  def self.deliveries
    @@shared_deliveries || []
  end
end
Mail::TestMailer.shared_deliveries = Mail::TestMailer.deliveries
