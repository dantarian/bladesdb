class Credit < ApplicationRecord
    belongs_to :money_transaction, class_name: "Transaction", foreign_key: "transaction_id"
    belongs_to :character
  
    validates_presence_of :character_id, if: -> { other_recipient.nil? }
    validates_presence_of :other_recipient, if: -> { character_id.nil? }
    
    auto_strip_attributes :other_recipient
    
    def subject_name
        unless character.nil?
            character.name_and_title
        else
            other_recipient
        end
    end
end
