class CharactersController < ApplicationController
    
    before_filter :authenticate_user!
    before_filter :new_character, :only => [:new]
    before_filter :find_character, :except => [:my_characters, :index, :new, :create, :new_player, :create_player, :show_all]
    before_filter :check_ajax, :except => [:my_characters, :index, :new, :create, :show, :show_all]
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
        @character.no_title = case params[:radio_title]
          when "no_title" then true
          else false
        end
        @guild_membership = @character.guild_memberships.first
        @guild_membership.character = @character
        @guild_membership.start_points = 0
        @guild_membership.declared_on = @character.declared_on
        @guild_membership.provisional = false
        @guild_membership.approved = (@guild_membership.guild ? nil : true)
        if @character.save
            flash[:notice] = I18n.t("character.success.created")
            reload_page
        else
            respond_to {|format| format.js { render :new } }
        end
    end
    
    def update_name
        @character.no_title = case params[:radio_title]
          when "no_title" then true
          else false
        end
        @character.title = case params[:radio_title]
          when "custom" then @character.title
          else nil
        end
        update_character(params.require(:character).permit(:name, :title, :no_title), :edit_name)
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
        @character.no_title = case params[:radio_title]
          when "no_title" then true
          else false
        end
        guild_membership = @character.guild_memberships.first
        guild_membership.character = @character
        guild_membership.declared_on ||= @character.declared_on
        guild_membership.start_points ||= 0
        if @character.save
            flash[:notice] = I18n.t("character.success.declared")
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
    
    private
        def full_declaration_params
            params.require(:character).permit(:name, :title, :no_title, :race_id, {:guild_memberships_attributes => [:id, :guild_id, :guild_branch_id, :start_points]}, :starting_points, :starting_florins, :starting_death_thresholds, :declared_on, :state)
        end
        
        def new_character_params
            params.require(:character).permit(:name, :title, :no_title, :race_id, {:guild_memberships_attributes => [:id, :guild_id, :guild_branch_id]}, :declared_on)
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
                flash[:notice] = I18n.t("character.success.updated")
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
                UserMailer.character_approval(@character).deliver_now if @character.approval_recently_set?
                flash[:notice] = I18n.t("character.success.updated")
                reload_page
            else
                flash[:error] = I18n.t("character.failure.updated")
                reload_page
            end                
        end
end
