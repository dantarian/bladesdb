class MonsterPointAdjustmentsController < ApplicationController
    before_action :authenticate_user!
    before_action :find_monster_point_adjustment, :except => [:new, :create]
    before_action :check_own_adjustment_or_ref_or_admin, :except => [:new, :create]
    before_action :check_ajax
    before_action :check_admin_or_character_ref_role, :only => [:approve, :reject]
    before_action :check_not_own_adjustment, :only => [:approve, :reject]
    
    def new
        @monster_point_adjustment = MonsterPointAdjustment.new
        @monster_point_adjustment.user = current_user
        @monster_point_adjustment.declared_on = Date.today
        respond_to do |format|
            format.js
        end
    end

    def edit
        unless @monster_point_adjustment.approved
            respond_to do |format|
                format.js
            end
        else
            flash[:notice] = I18n.t("user.monster_point_adjustment.failure.already_addressed")
            reload_page
        end
    end

    def create
        @monster_point_adjustment = MonsterPointAdjustment.new(monster_point_adjustment_params)
        @monster_point_adjustment.user = current_user

        if @monster_point_adjustment.save
            flash[:notice] = I18n.t("user.monster_point_adjustment.success.created")
            reload_page
        else
            respond_to do |format|
                format.js { render :new }
            end
        end
    end

    def update
        unless @monster_point_adjustment.approved
            @monster_point_adjustment.approved = nil
            @monster_point_adjustment.approved_by = nil
            @monster_point_adjustment.approved_at = nil
            if @monster_point_adjustment.update(monster_point_adjustment_params)
                flash[:notice] = I18n.t("user.monster_point_adjustment.success.updated")
                reload_page
            else
                respond_to do |format|
                    format.js { render :edit }
                end
            end
        else
            flash[:notice] = I18n.t("user.monster_point_adjustment.failure.already_addressed")
            reload_page
        end
    end
    
    def approve
        approve_or_reject_adjustment true, I18n.t("user.monster_point_adjustment.success.approved"), I18n.t("user.monster_point_adjustment.failure.approved")
    end
    
    def reject
        approve_or_reject_adjustment false, I18n.t("user.monster_point_adjustment.success.rejected"), I18n.t("user.monster_point_adjustment.failure.rejected")
    end
    
    protected
        def monster_point_adjustment_params
            params.require(:monster_point_adjustment).permit(:user_id, :points, :reason, :declared_on)
        end
    
        def find_monster_point_adjustment
            if params[:id]
               @monster_point_adjustment = MonsterPointAdjustment.find(params[:id])
           elsif params[:user_id]
               @user = User.find(params[:user_id])
               @monster_point_adjustment = @user.monster_point_adjustment
           end
        end
        
        def check_own_adjustment_or_ref_or_admin
            unless @monster_point_adjustment.user == current_user or current_user.is_admin_or_character_ref?
                permission_denied
            end
        end
        
        def check_not_own_adjustment
            if @monster_point_adjustment.user == current_user
                permission_denied
            end
        end
        
        def check_ajax
            unless request.xhr?
                flash[:error] = I18n.t("failure.inaccessible_url")
                reload_page
            end
        end
        
        def approve_or_reject_adjustment(state, success_message, failure_message)
            if @monster_point_adjustment.is_provisional?
                (state ? @monster_point_adjustment.approve(current_user) : @monster_point_adjustment.reject(current_user))
                if @monster_point_adjustment.save
                    UserMailer.monster_point_adjustment_approval(@monster_point_adjustment).deliver_now
                    flash[:notice] = success_message
                    reload_page
                else
                    flash[:error] = failure_message
                    reload_page
                end
            else
                flash[:error] = I18n.t("user.monster_point_adjustment.failure.already_approved", state: @monster_point_adjustment.approved ? I18n.t("approvals.approved") : I18n.t("approvals.rejected"))
                reload_page
            end
        end

end
