class CharacterPointAdjustmentsController < ApplicationController
    before_filter :authenticate_user!
    before_filter :find_character
    before_filter :find_character_point_adjustment, :except => [:new, :create]
    before_filter :check_own_character_or_ref_or_admin
    before_filter :check_ajax
    before_filter :check_admin_or_character_ref_role, :only => [:approve, :reject]
    before_filter :check_not_own_character, :only => [:approve, :reject]
    
    def new
        @character_point_adjustment = CharacterPointAdjustment.new
        @character_point_adjustment.character = @character
        @character_point_adjustment.declared_on = Date.today
        respond_to do |format|
            format.js
        end
    end

    def edit
        if @character_point_adjustment.is_provisional?
            respond_to do |format|
                format.js
            end
        else
            flash[:notice] = "Character Point adjustment already addressed by Character Refs."
            reload_page
        end
    end

    def create
        @character_point_adjustment = CharacterPointAdjustment.new(character_point_adjustment_params)
        @character_point_adjustment.character = @character
        if current_user.is_admin_or_character_ref? and @character.user != current_user
            @character_point_adjustment.approved = true
            @character_point_adjustment.approved_by = current_user
            @character_point_adjustment.approved_at = Time.now
        end

        if @character_point_adjustment.save
            flash[:notice] = 'Character Point adjustment requested.'
            reload_page
        else
            respond_to do |format|
                format.js { render :new }
            end
        end
    end

    def update
        if @character_point_adjustment.is_provisional?
            if @character_point_adjustment.update_attributes(character_point_adjustment_params)
                flash[:notice] = 'Character Point adjustment request updated.'
                reload_page
            else
                respond_to do |format|
                    format.js { render :edit }
                end
            end
        else
            flash[:notice] = "Character Point adjustment already addressed by Character Refs."
            reload_page
        end
    end
    
    def approve
        resolve_request :approved => true
    end
    
    def reject
        resolve_request :approved => false
    end
    
    protected
        def character_point_adjustment_params
            params.require(:character_point_adjustment).permit(:declared_on, :points, :reason)
        end
    
        def find_character
            @character = Character.find(params[:character_id])
        end
        
        def find_character_point_adjustment
            @character_point_adjustment = CharacterPointAdjustment.find(params[:id])
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
                        reload_page
                    }
                end
            end
        end
        
        def resolve_request(approved)
            if @character_point_adjustment.is_provisional?
                (approved ? @character_point_adjustment.approve(current_user) : @character_point_adjustment.reject(current_user))
                if @character_point_adjustment.save
                    UserMailer.character_point_adjustment_approval(@character_point_adjustment).deliver
                    flash[:notice] = "Character Point adjustment #{approved ? "approved" : "rejected"}."
                else
                    flash[:error] = "Character Point adjustment #{approved ? "approval" : "rejection"} failed."
                end
            else
                flash[:notice] = "Adjustment has already been #{@character_point_adjustment.approved ? "approved" : "rejected"}."
            end
            reload_page
        end

end
