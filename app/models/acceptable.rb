class Acceptable < ApplicationRecord

  TERMS_AND_CONDITIONS = "Terms and Conditions"

  def self.latest_terms_and_conditions
    where(flavour: TERMS_AND_CONDITIONS).order(created_at: :desc).first
  end

end
