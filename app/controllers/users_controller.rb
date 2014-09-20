class UsersController < ApplicationController
    # Protect these actions behind an admin login
    # before_filter :admin_required, :only => [:suspend, :unsuspend, :destroy, :purge]
    before_filter :find_user, :only => [:approve, 
                                        :suspend, 
                                        :unsuspend, 
                                        :destroy, 
                                        :undelete,
                                        :purge, 
                                        :resend_activation, 
                                        :monster_points, 
                                        :edit_user_name, 
                                        :update_user_name,
                                        :edit_login, 
                                        :update_login,
                                        :edit_email, 
                                        :update_email,
                                        :edit_mobile_number, 
                                        :update_mobile_number,
                                        :edit_emergency_details, 
                                        :update_emergency_details,
                                        :edit_general_notes, 
                                        :update_general_notes]
    before_filter :login_prohibited, :only => [:create]
    before_filter :check_administrator_role, :only => [:purge, :merge]
    before_filter :check_admin_or_committee_role, :only => [:destroy, :approve, :suspend, :unsuspend, :undelete, :edit, :resend_activation]
    before_filter :check_active_member, :only => [:index]
    before_filter :check_self_or_character_ref_role, :only => [:monster_points]
    before_filter :authenticate_user!, :only => [:show, :new_gm, :new_player, :new_monster, :create_gm, :create_player, :create_monster]
    before_filter :new_user, :only => [:new_gm, :new_player, :new_monster]
    before_filter :check_ajax, :only => [:edit_user_name, 
                                         :update_user_name,
                                         :edit_login, 
                                         :update_login,
                                         :edit_email, 
                                         :update_email,
                                         :edit_mobile_number, 
                                         :update_mobile_number,
                                         :edit_emergency_contact, 
                                         :update_emergency_contact,
                                         :edit_medical_notes, 
                                         :update_medical_notes,
                                         :edit_general_notes, 
                                         :update_general_notes]
    before_filter :check_self_or_administrator_role, 
                  :only => [:edit_user_name,
                            :update_user_name,
                            :edit_login, 
                            :update_login,
                            :edit_email, 
                            :update_email,
                            :edit_mobile_number, 
                            :update_mobile_number,
                            :edit_emergency_contact, 
                            :update_emergency_contact,
                            :edit_medical_notes, 
                            :update_medical_notes,
                            :edit_general_notes, 
                            :update_general_notes]                        

    def index
        @users = User.includes(:roles).to_a
    end

    # Show only a user's own profile if they're web-only.
    def show
        if current_user.is_normal?
            @user = User.find( params[:id] )
            render :profile
        else
            @user = current_user
            render :profile
        end
    end

    def profile
        @user = current_user
    end

    def resend_activation
        @user.resend_confirmation_instructions
        flash[:notice] = "Activation e-mail resent."
        redirect_to users_path
    end
    
    def edit_user_name
        respond_to { |format| format.js }
    end
    
    def update_user_name
        update_user :edit_user_name
    end
    
    def edit_login
        respond_to { |format| format.js }
    end
    
    def update_login
        update_user :edit_login
    end
    
    def edit_email
        respond_to { |format| format.js }
    end
    
    def update_email
        update_user :edit_email
    end
    
    def edit_mobile_number
        respond_to { |format| format.js }
    end
    
    def update_mobile_number
        update_user :edit_mobile_number
    end
    
    def edit_emergency_details
        respond_to { |format| format.js }
    end
    
    def update_emergency_details
        update_user :edit_emergency_details
    end
    
    def edit_general_notes
        respond_to { |format| format.js }
    end
    
    def update_general_notes
        update_user :edit_general_notes
    end

    def approve
        @user.approve
        @user.save!
        UserMailer.user_approval(@user).deliver
        redirect_to users_path
    end

    def suspend
        @user.suspend!
        redirect_to users_path
    end

    def unsuspend
        @user.unsuspend! 
        redirect_to users_path
    end

    def destroy
        @user.delete!
        redirect_to users_path
    end
    
    def undelete
        @user.undelete!
        redirect_to users_path
    end

    def purge
        @user.destroy
        redirect_to users_path
    end
    
    def monster_points
        render :template => "my_info/monster_points"
    end
  
    # There's no page here to update or destroy a user.  If you add those, be
    # smart -- make sure you check that the visitor is authorized to do so, that they
    # supply their old password along with a new one to update it, etc.

    # Methods for creating users on the fly as part of game debriefs
    
    def new_gm
        respond_to { |format| format.js }
    end
    
    def new_player
        respond_to { |format| format.js }
    end
    
    def new_monster
        respond_to { |format| format.js }
    end
    
    def create_gm
        create_user_for_debrief(params)
        @game = Game.find(params[:game_id])
        if @user.save
            @debrief = @game.debriefs.build
            @debrief.user = @user
            respond_to { |format| format.js { render "debriefs/new_gm" } }
        else
            respond_to { |format| format.js { render :new_gm } }
        end
    end

    def create_player
        create_user_for_debrief(params)
        @game = Game.find(params[:game_id])
        if @user.save
            @debrief = @game.debriefs.build
            @debrief.user = @user
            respond_to { |format| format.js { render "debriefs/new_player" } }
        else
            respond_to { |format| format.js { render :new_player } }
        end
    end

    def create_monster
        create_user_for_debrief(params)
        @game = Game.find(params[:game_id])
        if @user.save
            @debrief = @game.debriefs.build
            @debrief.user = @user
            respond_to { |format| format.js { render "debriefs/new_monster" } }
        else
            respond_to { |format| format.js { render :new_monster } }
        end
    end
    
    def merge_select_users
        @primary = nil
        @secondary = nil
        respond_to do |format|
            format.html
        end
    end
    
    def merge_select_data
        check_distinct_users(params) do
            respond_to do |format|
                format.html
            end          
        end
    end
    
    def merge
        check_distinct_users(params) do
            @primary_user.mastered_campaigns << @secondary_user.mastered_campaigns
            @primary_user.mastered_games << @secondary_user.mastered_games
            @primary_user.characters << @secondary_user.characters
            @primary_user.debriefs << @secondary_user.debriefs
            @primary_user.messages << @secondary_user.messages
            @primary_user.monster_point_adjustments << @secondary_user.monster_point_adjustments
            if @primary_user.save
                @secondary_user.destroy
                flash[:notice] = "Users successfully merged."
                redirect_to users_path
            else
                flash[:error] = "Failed to save merged user."
                render "merge_select_data"
            end
        end
    end

    protected
        def find_user
            @user = User.find(params[:id])
            @user.updating = true
        end
        
        def new_user
            @user = User.new
        end
        
        def create_user_for_debrief(params)
            @user = User.new(params.require(:user).permit(:name))
            @user.username = @user.name.delete(" ").downcase.slice(0, 40)
            @user.username += "_" while User.all.map{|user| user.username}.include? @user.username
        end
        
        def check_self_or_character_ref_role
            @user == current_user || current_user.is_character_ref?
        end
        
        def check_self_or_administrator_role
            @user == current_user || current_user.is_admin?
        end
        
        def check_distinct_users(params)
            @primary = params[:primary]
            @secondary = params[:secondary]
            @primary_user = User.find(@primary) unless @primary.nil? or @primary == ""
            @secondary_user = User.find(@secondary) unless @secondary.nil? or @secondary == ""
            if @primary_user.nil? or @secondary_user.nil? or @primary == @secondary
                flash[:error] = "Please ensure you have selected two distinct users to merge."
                render "merge_select_users"
            else
                yield
            end
        end
        
    private
        
        def update_user(failure_target)
            @user.emergency_last_updated = DateTime.now
            if @user.update_attributes(params.require(:user).permit(:name, :username, :email, :notes, :medical_notes, :food_notes, :emergency_last_updated, :mobile_number, :contact_name, :contact_number))
                if (@user != current_user) && current_user.is_admin_or_committee?
                   flash[ :notice ] = "User profile updated for #{@user.name}."
                else
                   flash[ :notice ] = "User profile updated."
                end
                reload_page
            else
                respond_to { |format| format.js { render failure_target } }
            end
        end

end
