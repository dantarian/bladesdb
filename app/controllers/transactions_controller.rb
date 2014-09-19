class TransactionsController < ApplicationController
  
    before_filter :authenticate_user!
    before_filter :check_ajax
    before_filter :find_character, :except => [ :create, :destroy ]
    before_filter :find_transaction, :only => [ :destroy ]
    before_filter :check_recipient_or_character_ref, :only => [ :destroy ]
  
    def new
        @to_other = false
        @transfer_from = true
        @transaction = Transaction.new
        @transaction.build_debit
        @transaction.debit.character = @character
        @transaction.build_credit
        respond_to do |format|
            format.js
        end
    end

    def new_to_character
        @from_other = false
        @transfer_from = false
        @transaction = Transaction.new
        @transaction.build_debit
        @transaction.build_credit
        @transaction.credit.character = @character
        respond_to do |format|
            format.js { render :new }
        end
    end

    def create
        @to_other = params[:to] == "other"
        @from_other = params[:to] == "other"
        @transfer_from = params[:transfer_from] == "true"
        if not @transfer_from and not current_user.is_character_ref?
            permission_denied
        else
            @transaction = Transaction.new(transaction_params)
            
            if @transaction.save
                character = Character.find(@transfer_from ? @transaction.debit.character : @transaction.credit.character)
                flash[:notice] = 'Money transferred successfully.'
                reload_page
            else
                respond_to do |format|
                    format.js { render :new }
                end
            end
        end
    end

    def destroy
        character = @transaction.credit.character
        @transaction.destroy
        reload_page
    end
    
    protected
        def find_character
            @character = Character.find(params[:character_id])
        end
        
        def find_transaction
            @transaction = Transaction.find(params[:id])
        end
        
        def check_recipient_or_character_ref
            unless (@transaction.credit.character.user == current_user) or (current_user.is_character_ref? and @transaction.debit.character.user == current_user)
                permission_denied
            end
        end
        
        def transaction_params
            params.require(:transaction).permit(:transaction_date, :value, :description, :credit_attributes => [:transaction_id, :character_id, :other_recipient], :debit_attributes => [:transaction_id, :character_id, :other_source])
        end
end
