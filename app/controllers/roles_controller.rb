class RolesController < ApplicationController
    before_filter :check_admin_or_committee_role

    # GET /roles
    # GET /roles.xml
     def index
        @user = User.find( params[:user_id] )
        @roles = Role.all

        respond_to do |format|
            format.js { render :roles }
        end
     end

    # PUT /roles/1
    # PUT /roles/1.xml
    def update
        @user = User.find( params[:user_id] )
        @roles = Role.all
        
        @user.roles.clear
        
        @roles.each do |role|
            if (params[:post][:role][role.rolename][:hasrole].to_s == 1.to_s)
              @user.roles << role
            end
        end
        
        flash[:notice] = 'Roles updated.'
        reload_page
        
    end
    
end
