class UsersController < ApplicationController
    # Protect these actions behind an admin login
    before_action :find_user, :only => [:approve, 
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
    before_action :login_prohibited, :only => [:create]
    before_action :check_administrator_role, :only => [:purge, :merge]
    before_action :check_admin_or_committee_role, :only => [:destroy, :approve, :suspend, :unsuspend, :undelete, :edit, :resend_activation]
    before_action :check_self_or_character_ref_role, :only => [:monster_points]
    before_action :authenticate_user!, :only => [:index, :show, :new_gm, :new_player, :new_monster, :create_gm, :create_player, :create_monster]
    before_action :check_active_member, :only => [:index]
    before_action :new_user, :only => [:new_gm, :new_player, :new_monster]
    before_action :check_ajax, :only => [:edit_user_name, 
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
    before_action :check_self_or_administrator_role, 
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
            redirect_to user_profile_path
        end
    end

    def profile
        @user = current_user
    end

    def resend_activation
        @user.resend_confirmation_instructions
        flash[:notice] = I18n.t("user.success.email_resent")
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
        @user.emergency_last_updated = Date.today
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
        UserMailer.user_approval(@user).deliver_now
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
          begin
          User.transaction do
              @primary_user.updating = true
              
              @secondary_user.characters.to_a.each do |character|
                character.user = @primary_user
                character.save!
              end
              
              @secondary_user.messages.to_a.each do |message|
                message.user = @primary_user
                message.merge = true
                message.save!
              end
              
              @secondary_user.game_applications.to_a.each do |application|
                unless application.game.start_date < Date.today
                    application.user = @primary_user
                    application.save!
                else
                    application.destroy!
                end
              end
              
              @secondary_user.game_attendances.to_a.each do |game_attendance|
                  unless game_attendance.game.start_date < Date.today
                      unless @primary_user.game_attendances.to_a.any? {|attendance| attendance.game == game_attendance.game} then
                        game_attendance.user = @primary_user
                        game_attendance.save!
                      else
                        game_attendance.destroy!
                      end
                  else
                      game_attendance.destroy!
                  end
                  
              end
              
              @secondary_user.debriefs.to_a.each do |game_debrief|
                  unless @primary_user.debriefs.to_a.any? {|debrief| debrief.game == game_debrief.game} then
                    game_debrief.user = @primary_user
                    game_debrief.save!
                  else
                    game_debrief.destroy!
                  end
              end
              
              @secondary_user.mastered_games.to_a.each do |game|
                  unless @primary_user.mastered_games.to_a.any? {|master| master == game} then
                    game.association(:gamesmasters).insert_record(@primary_user)
                  end
                  game.gamesmasters.destroy(@secondary_user)
                  game.save!
              end
              
              unless @primary_user.monster_point_adjustments.any? then
                  @secondary_user.monster_point_adjustments.to_a.each do |adjust|
                    adjust.user = @primary_user
                    adjust.save!
                  end
              else
                  @secondary_user.monster_point_adjustments.to_a.each do |adjust|
                    adjust.destroy!
                  end
              end
              
              if @primary_user.monster_point_declaration.nil? and not @secondary_user.monster_point_declaration.nil? then
                  mpd = MonsterPointDeclaration.new
                  mpd.user = @primary_user
                  mpd.declared_on = @secondary_user.monster_point_declaration.declared_on
                  mpd.points = @secondary_user.monster_point_declaration.points
                  mpd.approved = @secondary_user.monster_point_declaration.approved
                  mpd.approved_at = @secondary_user.monster_point_declaration.approved_at
                  mpd.approved_by = @secondary_user.monster_point_declaration.approved_by
                  mpd.save!
                  @secondary_user.monster_point_declaration.destroy!
              end
              
              @primary_user.save!
              @secondary_user.destroy!
              flash[:notice] = I18n.t("user.success.merged")
              redirect_to users_path
           end
           rescue
              flash[:error] = I18n.t("user.failure.merged")
              render "merge_select_data"
              raise
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
                flash[:error] = I18n.t("user.failure.checked")
                render "merge_select_users"
            else
                yield
            end
        end
        
    private
        
        def update_user(failure_target)
            if @user.update_attributes(params.require(:user).permit(:name, :username, :email, :notes, :medical_notes, :food_notes, :emergency_last_updated, :mobile_number, :contact_name, :contact_number))
                if (@user != current_user) && current_user.is_admin_or_committee?
                   flash[:notice] = I18n.t("user.success.other_profile_updated", name: @user.name)
                else
                   flash[:notice] = I18n.t("user.success.own_profile_updated")
                end
                reload_page
            else
                respond_to { |format| format.js { render failure_target } }
            end
        end

end