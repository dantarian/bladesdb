class CharactersController < ApplicationController
    
    before_filter :authenticate_user!
    before_filter :new_character, :only => [:new, :import]
    before_filter :find_character, :except => [:my_characters, :index, :new, :import, :create, :new_player, :create_player, :show_all]
    before_filter :check_ajax, :except => [:my_characters, :index, :new, :import, :create, :show, :show_all]
    before_filter :check_own_character_or_ref, 
                  :only => [:edit, 
                            :edit_bio, 
                            :edit_date_of_birth, 
                            :edit_address, 
                            :edit_notes, 
                            :edit_player_notes,
                            :update,
                            :update_bio,
                            :update_date_of_birth,
                            :update_address,
                            :update_notes,
                            :update_player_notes,
                            :edit_rejected,
                            :update_rejected, 
                            :reactivate, 
                            :retire, 
                            :perm_kill, 
                            :resurrect,
                            :declare,
                            :save_declaration,
                            :recycle]
    before_filter :check_character_ref_role, :only => [:approve, :reject]
    before_filter :check_not_own_character, :only => [:approve, :reject, :edit_gm_notes, :update_gm_notes]
    before_filter :check_not_already_approved_or_rejected, :only => [:approve, :reject]
    before_filter :check_gm_or_character_ref, :only => [:edit_gm_notes, :update_gm_notes]

    def my_characters
        @characters = current_user.characters.joins(:character_state).order("current_character_status.points DESC")
        respond_to {|format| format.html }
    end
    
    def index
        @characters = Character.joins(:character_state).where(state: :active).order("current_character_status.points DESC")
        respond_to {|format| format.html }
    end

    def show
        respond_to {|format| format.html }
    end
    
    def show_all
        @showall = true
        @characters = Character.joins(:character_state).order("current_character_status.points DESC")
        respond_to {|format| format.html {render :index}}
    end

    def new
        respond_to {|format| format.js }
    end

    def import
        respond_to {|format| format.js }
    end
    
    def edit_name
        respond_to {|format| format.js }
    end
    
    def edit_bio
        respond_to {|format| format.js }
    end
    
    def edit_date_of_birth
        respond_to {|format| format.js }
    end
    
    def edit_address
        respond_to {|format| format.js }
    end
    
    def edit_notes
        respond_to {|format| format.js }
    end
    
    def edit_player_notes
        respond_to {|format| format.js }
    end
    
    def edit_gm_notes
        respond_to {|format| format.js }
    end

    def edit_rejected
        respond_to {|format| format.js }
    end
    
    def declare
        @character.declared_on = Date.today
        @character.guild_memberships.build
        respond_to {|format| format.js }
    end
    
    def create
        @character = Character.new(new_character_params)
        @character.user = current_user
        @character.state = Character::Active
        @character.starting_points = 20
        @character.starting_death_thresholds = @character.race.death_thresholds
        @guild_membership = @character.guild_memberships.first
        @guild_membership.character = @character
        @guild_membership.start_points = 0
        @guild_membership.declared_on = @character.declared_on
        @guild_membership.provisional = false
        @guild_membership.approved = (@guild_membership.guild ? nil : true)
        if @character.save
            flash[:notice] = 'Character was successfully created.'
            reload_page
        else
            respond_to {|format| format.js { render :new } }
        end
    end

    def create_import
        @character = Character.new(full_declaration_params)
        @character.user = current_user
        guild_membership = @character.guild_memberships.first
        guild_membership.character = @character
        guild_membership.declared_on ||= @character.declared_on
        guild_membership.start_points ||= 0
        if @character.save
            flush[:notice] = "Character was successfully created."
            reload_page
        else
            respond_to {|format| format.js { render :import } }
        end
    end
    
    def update_name
        update_character(params.require(:character).permit(:name, :title), :edit_name)
    end
    
    def update_bio
        update_character(params.require(:character).permit(:biography), :edit_bio)
    end
    
    def update_date_of_birth
        update_character(params.require(:character).permit(:date_of_birth, :date_of_birth_public), :edit_date_of_birth)
    end
    
    def update_address
        update_character(params.require(:character).permit(:address), :edit_address)
    end
    
    def update_notes
        update_character(params.require(:character).permit(:notes), :edit_notes)
    end
    
    def update_player_notes
        update_character(params.require(:character).permit(:player_notes), :edit_notes)
    end
    
    def update_gm_notes
        update_character(params.require(:character).permit(:gm_notes), :edit_gm_notes)
    end
    
    def reactivate
        change_character_state Character::Active
    end
    
    def retire
        change_character_state Character::Retired
    end
    
    def perm_kill
        change_character_state Character::PermDead
    end
    
    def recycle
        change_character_state Character::Recycled
    end
    
    def resurrect
        if current_user.is_admin_or_character_ref? and @character.user != current_user
            @character.approved = true
            @character.approved_by = current_user
            @character.approved_on = Time.now
        else
            @character.approved = nil
            @character.approved_by = nil
            @character.approved_on = nil
        end
        change_character_state Character::Active
    end
    
    def approve
        @character.approve(current_user)
        save_character
    end
    
    def reject
        @character.reject(current_user)
        save_character
    end
    
    def update_rejected
        @character.approved = nil
        @character.approved_on = nil
        @character.approved_by = nil
        update_character(full_declaration_params, :edit_rejected)
    end
    
    def save_declaration
        @character.approved = nil
        @character.approved_on = nil
        @character.approved_by = nil
        @character.state = Character::Active
        @character.attributes = full_declaration_params
        guild_membership = @character.guild_memberships.first
        guild_membership.character = @character
        guild_membership.declared_on ||= @character.declared_on
        guild_membership.start_points ||= 0
        if @character.save
            flash[:notice] = 'Character was successfully declared.'
            reload_page
        else
            respond_to {|format| format.js { render :declare } }
        end
    end

    def new_player
        @game = Game.find(params[:game_id])
        @user = User.find(params[:user_id])
        @character = Character.new
        respond_to {|format| format.js }
    end
    
    def create_player
        @game = Game.find(params[:game_id])
        @user = User.find(params[:user_id])
        @character = Character.new(params.require(:character).permit(:name))
        @character.user = @user
        @character.state = Character::Undeclared
        @character.race = Race.find_by(name: "Human")
        @character.starting_death_thresholds = 0
        if @character.save
            @debrief = @game.debriefs.build
            @debrief.user = @user
            @debrief.character = @character
            respond_to {|format| format.js { render "debriefs/new_player" } }
        else
            respond_to {|format| format.js { render :new_player } }
        end
    end
    
    def merge_select_user
        @user = nil
        respond_to do |format|
            format.html
        end
    end
    
    def merge_select_characters
        @primary = nil
        @secondary = nil
        respond_to do |format|
            format.html
        end
    end
    
    def merge_select_data
        check_same_owner(params) do
            check_distinct_characters(params) do
                respond_to do |format|
                    format.html
                end          
            end
        end
    end
    
    # def merge
    #     check_same_owner(params) do
    #         check_distinct_characters(params) do
    #             @primary_character.credits << @secondary_character.credits
    #             @primary_character.debits << @secondary_character.debits
    #             @primary_character.debriefs << @secondary_character.debriefs
    #             @primary_character.game_attendances << @secondary_character.game_attendances
    #             @primary_character.messages << @secondary_character.messages
    #             @monster_point_adjustment = @primary_character.user.monster_point_adjustments.build
    #             @monster_point_adjustment.declared_on = Date.today
    #             @monster_point_adjustment.points = @secondary_character.monster_point_spends.monster_points_spent
    #             @monster_point_adjustment.reason = "Character merge."
    #             if @primary_character.save
    #                 @monster_point_adjustment.save
    #                 @secondary_character.destroy
    #                 flash[:notice] = "Characters successfully merged."
    #                 redirect_to users_path
    #             else
    #                 flash[:error] = "Failed to save merged character."
    #                 render "merge_select_data"
    #             end
    #         end
    #     end
    # end
    
    protected
        
        def check_same_owner(params)
            @primary = params[:primary]
            @secondary = params[:secondary]
            @primary_character = Character.find(@primary) unless @primary.nil? or @primary == ""
            @secondary_character = Character.find(@secondary) unless @secondary.nil? or @secondary == ""
            if !(@primary_character.user_id == @secondary_character.user_id)
                flash[:error] = "Characters must belong to the same user."
                render "merge_select_characters"
            else
                yield
            end
        end
        
        def check_distinct_characters(params)
            @primary = params[:primary]
            @secondary = params[:secondary]
            @primary_character = Character.find(@primary) unless @primary.nil? or @primary == ""
            @secondary_character = Character.find(@secondary) unless @secondary.nil? or @secondary == ""
            if @primary_character.nil? or @secondary_character.nil? or @primary == @secondary
                flash[:error] = "Please ensure you have selected two distinct characters to merge."
                render "merge_select_characters"
            else
                yield
            end
        end

    private
        def full_declaration_params
            params.require(:importing)
            params.require(:character).permit(:name, :title, :race_id, {:guild_memberships_attributes => [:id, :guild_id, :guild_branch_id, :guild_starting_points]}, :starting_points, :starting_florins, :starting_death_thresholds, :declared_on, :state)
        end
        
        def new_character_params
            params.require(:character).permit(:name, :title, :race_id, {:guild_memberships_attributes => [:id, :guild_id, :guild_branch_id]}, :declared_on)
        end
    
        def new_character
            @character = Character.new
            @character.guild_memberships.build
            @character.declared_on = Date.today
        end
        
        def find_character
            @character = Character.find(params[:id])
        end
        
        def check_own_character_or_ref
            unless @character.user == current_user or current_user.is_character_ref?
                permission_denied
            end
        end
        
        def check_not_own_character
            if @character.user == current_user
                permission_denied
            end
        end
        
        def check_gm_or_character_ref
            unless current_user.is_gm_for?(@character) or current_user.is_character_ref?
                permission_denied
            end
        end
        
        def check_not_already_approved_or_rejected
            unless @character.approved.nil?
                flash[:error] = "Character has already been #{@character.approved ? "approved" : "rejected"}."
                reload_page
            end
        end
        
        def update_character(parameters, failure_response)
            if @character.update_attributes(parameters)
                flash[:notice] = 'Character was successfully updated.'
                reload_page
            else
                respond_to {|format| format.js { render failure_response } }
            end
        end
        
        def change_character_state(state)
            @character.state = state
            save_character
        end
        
        def save_character
            if @character.save
                UserMailer.character_approval(@character).deliver
                flash[:notice] = "Character was successfully updated."
                reload_page
            else
                flash[:error] = "Failed to update character."
                reload_page
            end                
        end
end
