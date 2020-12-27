module AcceptableTestHelper
  module_function # Ensure that all subsequent methods are available as Module Functions

  def add_terms_and_conditions(text: "Some text", timestamp: Time.current)
    Acceptable.create!(text: text, created_at: timestamp, flavour: Acceptable::TERMS_AND_CONDITIONS)
  end

end
