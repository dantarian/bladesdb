class DeathThresholdAdjustmentsController < ApplicationController
    before_action :authenticate_user!
    before_action :find_character
    before_action :find_death_threshold_adjustment, :except => [:new, :create]
    before_action :check_own_character_or_ref_or_admin
    before_action :check_ajax
    before_action :check_admin_or_character_ref_role, :only => [:approve, :reject]
    before_action :check_not_own_character, :only => [:approve, :reject]
    
    def new
        @death_threshold_adjustment = DeathThresholdAdjustment.new
        @death_threshold_adjustment.character = @character
        @death_threshold_adjustment.declared_on = Date.today
        respond_to do |format|
            format.js
        end
    end

    def edit
        if @death_threshold_adjustment.is_provisional?
            respond_to do |format|
                format.js
            end
        else
            flash[:notice] = "Death Threshold adjustment already addressed by Character Refs."
            reload_page
        end
    end

    def create
        @death_threshold_adjustment = DeathThresholdAdjustment.new(death_threshold_adjustment_params)
        @death_threshold_adjustment.character = @character
        if current_user.is_admin_or_character_ref? and @character.user != current_user
            @death_threshold_adjustment.approved = true
            @death_threshold_adjustment.approved_by = current_user
            @death_threshold_adjustment.approved_at = Time.now
        end

        if @death_threshold_adjustment.save
            flash[:notice] = 'Death Threshold adjustment requested.'
            reload_page
        else
            respond_to do |format|
                format.js { render :new }
            end
        end
    end

    def update
        if @death_threshold_adjustment.is_provisional?
            if @death_threshold_adjustment.update_attributes(death_threshold_adjustment_params)
                flash[:notice] = 'Death Threshold adjustment request updated.'
                reload_page
            else
                respond_to do |format|
                    format.js { render :edit }
                end
            end
        else
            flash[:notice] = "Death Threshold adjustment already addressed by Character Refs."
            reload_page
        end
    end
    
    def approve
        approve_or_reject_adjustment :state => true
    end
    
    def reject
        approve_or_reject_adjustment :state => false
    end
    
    protected
        def death_threshold_adjustment_params
            params.require(:death_threshold_adjustment).permit(:declared_on, :change, :reason)
        end
    
        def find_character
            @character = Character.find(params[:character_id])
        end
        
        def find_death_threshold_adjustment
            @death_threshold_adjustment = DeathThresholdAdjustment.find(params[:id])
        end
        
        def check_own_character_or_ref_or_admin
            unless @character.user == current_user or current_user.is_admin_or_character_ref?
                permission_denied
            end
        end
        
        def check_not_own_character
            if @character.user == current_user
                permission_denied
            end
        end
        
        def check_ajax
            unless request.xhr?
                respond_to do |format|
                    format.html {
                        flash[:error] = "The requested URL is not accessible directly."
                        redirect_to @character
                    }
                end
            end
        end
        
        def approve_or_reject_adjustment(state)
            if @death_threshold_adjustment.is_provisional?
                (state ? @death_threshold_adjustment.approve(current_user) : @death_threshold_adjustment.reject(current_user))
                if @death_threshold_adjustment.save
                    UserMailer.death_threshold_adjustment_approval(@death_threshold_adjustment).deliver_now
                    flash[:notice] = "Death Threshold adjustment #{state ? "approved" : "rejected"}."
                else
                    flash[:error] = "Death Threshold adjustment #{state ? "approval" : "rejection"} failed."
                end
            else
                flash[:error] = "Adjustment has already been #{@death_threshold_adjustment.approved ? "approved" : "rejected"}."
            end
            reload_page
        end

end
