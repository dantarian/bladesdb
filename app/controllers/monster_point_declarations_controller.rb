class MonsterPointDeclarationsController < ApplicationController
    before_filter :authenticate_user!
    before_filter :find_monster_point_declaration, :except => [:new, :create]
    before_filter :check_own_declaration_or_ref_or_admin, :except => [:new, :create]
    before_filter :check_ajax
    before_filter :check_admin_or_character_ref_role, :only => [:approve, :reject]
    before_filter :check_not_own_declaration, :only => [:approve, :reject]
    
    def new
        @monster_point_declaration = MonsterPointDeclaration.new
        @monster_point_declaration.user = current_user
        @monster_point_declaration.declared_on = Date.today
        respond_to do |format|
            format.js
        end
    end

    def edit
        unless @monster_point_declaration.approved
            respond_to do |format|
                format.js
            end
        else
            flash[:notice] = I18n.t("user.monster_point_declaration.failure.already_addressed")
            reload_page
        end
    end

    def create
        @monster_point_declaration = MonsterPointDeclaration.new(monster_point_declaration_params)
        @monster_point_declaration.user = current_user

        if @monster_point_declaration.save
            flash[:notice] = I18n.t("user.monster_point_declaration.success.created")
            reload_page
        else
            respond_to do |format|
                format.js { render :new }
            end
        end
    end

    def update
        unless @monster_point_declaration.approved
            @monster_point_declaration.approved = nil
            @monster_point_declaration.approved_by = nil
            @monster_point_declaration.approved_at = nil
            if @monster_point_declaration.update_attributes(monster_point_declaration_params)
                flash[:notice] = I18n.t("user.monster_point_declaration.success.updated")
                reload_page
            else
                respond_to do |format|
                    format.js { render :edit }
                end
            end
        else
            flash[:notice] = I18n.t("user.monster_point_declaration.failure.already_addressed")
            reload_page
        end
    end
    
    def approve
        approve_or_reject_declaration true, I18n.t("user.monster_point_declaration.success.approved"), I18n.t("user.monster_point_declaration.failure.approved")
    end
    
    def reject
        approve_or_reject_declaration false, I18n.t("user.monster_point_declaration.success.rejected"), I18n.t("user.monster_point_declaration.failure.rejected")
    end
    
    protected
        def monster_point_declaration_params
            params.require(:monster_point_declaration).permit(:user_id, :points, :declared_on)
        end
    
        def find_monster_point_declaration
            if params[:id]
               @monster_point_declaration = MonsterPointDeclaration.find(params[:id])
           elsif params[:user_id]
               @user = User.find(params[:user_id])
               @monster_point_declaration = @user.monster_point_declaration
           end
        end
        
        def check_own_declaration_or_ref_or_admin
            unless @monster_point_declaration.user == current_user or current_user.is_admin_or_character_ref?
                permission_denied
            end
        end
        
        def check_not_own_declaration
            if @monster_point_declaration.user == current_user
                permission_denied
            end
        end
        
        def check_ajax
            unless request.xhr?
                flash[:error] = I18n.t("failure.inaccessible_url")
                reload_page
            end
        end
        
        def approve_or_reject_declaration(state, success_message, failure_message)
            if @monster_point_declaration.is_provisional?
                (state ? @monster_point_declaration.approve(current_user) : @monster_point_declaration.reject(current_user))
                if @monster_point_declaration.save
                    UserMailer.monster_point_declaration_approval(@monster_point_declaration).deliver_now
                    flash[:notice] = success_message
                    reload_page
                else
                    flash[:notice] = failure_message
                    reload_page
                end
            else
                flash[:notice] = I18n.t("user.monster_point_declaration.failure.already_approved", state: @monster_point_declaration.approved ? I18n.t("approvals.approved") : I18n.t("approvals.rejected"))
                reload_page
            end
        end
end
