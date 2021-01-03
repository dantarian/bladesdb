class Transaction < ApplicationRecord
    belongs_to :approved_by, class_name: "User", optional: true
    has_one :credit, :dependent => :destroy, inverse_of: :money_transaction
    has_one :debit, :dependent => :destroy, inverse_of: :money_transaction
  
    accepts_nested_attributes_for :credit, :debit
  
    validates_presence_of :transaction_date
    validates_presence_of :value
    validates :value, numericality: { only_integer: true, greater_than: 0}
    validates_presence_of :description
    validate :creditor_has_enough_money
    validate :character_declared_before_transaction
    
    auto_strip_attributes :description
    
    def creditor_has_enough_money
        unless debit.character.nil? or value.nil? or value == ""
            available = debit.character.money_on(transaction_date)
            errors.add(:value, I18n.t("character.money_transfers.validation.not_enough_money", money: available)) if available < value
        end
    end
    
    def character_declared_before_transaction
        unless debit.character.nil? or value.nil? or value == ""
            if debit.character.declared_on > transaction_date
                errors.add(:value, "cannot be before the character was declared") 
            end
        end
    end
end
