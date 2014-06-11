class Transaction < ActiveRecord::Base
    belongs_to :approved_by, :class_name => "User"
    has_one :credit, :dependent => :destroy
    has_one :debit, :dependent => :destroy
  
    accepts_nested_attributes_for :credit, :debit
  
    validates_presence_of :transaction_date
    validates_presence_of :value
    validates_numericality_of :value, :only_integer => true, :greater_than => 0
    validates_presence_of :description
    validate :creditor_has_enough_money
    
    auto_strip_attributes :description
    
    def creditor_has_enough_money
        unless debit.character.nil? or value.nil? or value == ""
            errors.add(:value, "cannot be more money than the character has available") if debit.character.money < value
        end
    end
end
