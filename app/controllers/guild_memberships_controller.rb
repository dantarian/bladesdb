class GuildMembershipsController < ApplicationController
    before_filter :authenticate_user!
    before_filter :find_character
    before_filter :set_approvals_origin, :only => [:make_full_from_approvals, :eject_from_approvals, :approve_from_approvals, :provisionally_approve_from_approvals, :reject_from_approvals]
    before_filter :set_non_approvals_origin, :except => [:make_full_from_approvals, :approve_from_approvals, :provisionally_approve_from_approvals, :reject_from_approvals]
    before_filter :find_guild_membership, :except => [:new, :create, :branch_change, :create_guild_branch_change, :leave, :make_full, :make_full_from_approvals, :eject, :eject_from_approvals]
    before_filter :get_current_guild_membership, :only => [:eject, :eject_from_approvals]
    before_filter :check_guild_membership_request_provisional, :only => [:approve, :provisionally_approve, :reject, :approve_from_approvals, :provisionally_approve_from_approvals, :reject_from_approvals]
    before_filter :new_or_unprocessed_guild_membership, :only => [:leave, :eject, :eject_from_approvals]
    before_filter :new_guild_membership, :only => [:new, :make_full, :make_full_from_approvals]
    before_filter :check_current_guild_membership_provisional, :only => [:make_full, :make_full_from_approvals]
    before_filter :create_from_params, :only => [:create, :create_guild_branch_change]
    before_filter :check_own_character, :only => [:leave, :destroy]
    before_filter :check_ajax

    def leave
        attempt_save_without_dialog(
            I18n.t("character.guild_membership.success.left_guild"),
            I18n.t("character.guild_membership.failure.left_guild"))
    end    

    def eject
        do_eject
    end

    def eject_from_approvals
        do_eject
    end
  
    def branch_change
        @guild_membership = @character.guild_memberships.where(approved: nil).last || @character.guild_memberships.where(approved: true).last
        respond_to do |format|
            format.js { render :change_guild_branch }
        end
    end
  
    def make_full
        do_make_full
    end
    
    def approve
        do_approve
    end
    
    def provisionally_approve
        do_provisional_approval
    end
    
    def reject
        do_reject
    end
  
    def new
        respond_to do |format|
            format.js
        end
    end

    def edit
        @guild_membership = GuildMembership.find(params[:id])
    end

    def create
        do_create(I18n.t("character.guild_membership.success.guild_changed")) {
            respond_to do |format|
                format.js { render :new }
            end           
        }
    end

    def create_guild_branch_change
        do_create(I18n.t("character.guild_membership.success.branch_changed")) {
            respond_to do |format|
                format.js { render :change_guild_branch }
            end
        }
    end

    def destroy
        @guild_membership.destroy
        flash[:notice] = I18n.t("character.guild_membership.success.cancelled")
        reload_page
    end
    
    protected
        def guild_membership_params
            params.require(:guild_membership).permit(:character_id, :guild_id, :guild_branch_id)
        end
        
        def find_character
            @character = Character.find(params[:character_id])
        end
        
        def find_guild_membership
            @guild_membership = @character.guild_memberships.find(params[:id])
        end
        
        def get_current_guild_membership
            @guild_membership = @character.guild_memberships.where(approved: true).last
        end

        def new_or_unprocessed_guild_membership
            @guild_membership = @character.guild_memberships.where(approved: nil).last || new_guild_membership
            @guild_membership.guild = nil
            @guild_membership.guild_branch = nil
        end

        def new_guild_membership
            @guild_membership = @character.guild_memberships.build
            @guild_membership.declared_on = Date.today
            return @guild_membership
        end
        
        def check_guild_membership_request_provisional
            unless @guild_membership.approved.nil?
                flash[:error] = "The selected guild membership request has already been processed."
                reload_page
            end
        end
        
        def check_current_guild_membership_provisional
            unless @character.guild_memberships.where(approved: true).last.provisional
                flash[:error] = "#{@character.name}'s current guild membership is not provisional."
                reload_page
            end
        end
        
        def check_own_character
            unless @character.user == current_user
                permission_denied
            end
        end
        
        def check_ajax
            unless request.xhr?
                flash[:error] = I18n.t("failure.inaccessible_url")
                reload_page
            end
        end
        
        def attempt_save_without_dialog(success_message, failure_message)
            if @guild_membership.save
                UserMailer.guild_change_approval(@guild_membership).deliver_now if @guild_membership.approval_recently_set?
                flash[:notice] = success_message
            else
                flash[:error] = failure_message + @guild_membership.errors.full_messages.to_sentence
            end
            reload_page
        end
        
        def approve_current_membership
            @guild_membership.approved = true
            @guild_membership.approved_by = current_user
            @guild_membership.approved_at = Time.now
        end
        
        def set_approvals_origin
            @from_approvals = true
        end
        
        def set_non_approvals_origin
            @from_approvals = false
        end
        
        def do_eject
            approve_current_membership
            attempt_save_without_dialog(
                "#{@character.name} was ejected from their guild.",
                "Failed to eject #{@character.name} from their guild." )
        end
        
        def do_make_full
            @guild_membership.guild = @character.current_guild_membership.guild
            @guild_membership.guild_branch = @character.current_guild_membership.guild_branch
            @guild_membership.approve(current_user)
            attempt_save_without_dialog(
                "#{@character.name} was promoted to full member of their guild.", 
                "Failed to promote #{@character.name} to full member of their guild." )
        end
        
        def do_approve
            @guild_membership.approve(current_user)
            if @guild_membership.provisional
                attempt_save_without_dialog(
                    "#{@character.name}'s guild change application was provisionally approved.",
                    "Failed to provisionally approve #{@character.name}'s guild change application." )
            else
                attempt_save_without_dialog(
                    "#{@character.name}'s guild change application was approved.",
                    "Failed to approve #{@character.name}'s guild change application." )
            end
        end
        
        def do_provisional_approval
            @guild_membership.provisional = true
            do_approve
        end
        
        def do_reject
            @guild_membership.reject(current_user)
            attempt_save_without_dialog(
                "#{@character.name}'s guild change application was rejected.",
                "Failed to reject #{@character.name}'s guild change application." )
        end
        
        def create_from_params
            @guild_membership = @character.guild_memberships.where(approved: nil).last
            if @guild_membership.nil?
                @guild_membership = GuildMembership.new(guild_membership_params)
            else
                @guild_membership.attributes = guild_membership_params
                @guild_membership.guild_branch = nil if @guild_membership.guild.nil? or not @guild_membership.guild.has_branches?
            end
            @guild_membership.character = @character
            @guild_membership.declared_on = Date.today
        end
        
        def do_create(success_message)
            if @guild_membership.save
                flash[:notice] = success_message
                reload_page
            else
                yield
            end          
        end
end
