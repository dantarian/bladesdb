class Acceptable < ActiveRecord::Base
  has_many :acceptances

  TERMS_AND_CONDITIONS = "Terms and Conditions"

  def self.latest_terms_and_conditions
    where(flavour: TERMS_AND_CONDITIONS).order(created_at: :desc).first
  end

  def accepted_by?(user)
    # Returns true if the most recent acceptance for this Acceptable by the specified user was positive. False otherwise.
    self.acceptances.where(user_id: user.id).order(created_at: :desc).first.try(:accepted) || false
  end

end
