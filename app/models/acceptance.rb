class Acceptance < ActiveRecord::Base
  belongs_to :acceptance
  belongs_to :user
end
