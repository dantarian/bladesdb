class CommitteeContactsController < ApplicationController
    before_action :check_admin_or_committee_role, :only => [:new, :create]
    
    def new
        @email = ContactForm.new
    end
    
    def create
        @email = ContactForm.new(email_params)
        @email.from_user = "committee@bathlarp.co.uk"
        @email.to_user = "committee@bathlarp.co.uk"
        @email.subject = "[BathLARP] " + @email.subject
        
        users = User.includes(:roles).to_a
        
        @email.bcc_list = case params[:radio_type]
        when "current_members" then users.select{|user| user.is_normal?}.collect(&:email).join(", ")
            when "webonly_members" then users.select{|user| user.is_webonly?}.collect(&:email).join(", ")
            when "experienced_gms" then users.select{|user| user.is_experienced_gm?}.collect(&:email).join(", ")
            when "first_aiders" then users.select{|user| user.is_first_aider?}.collect(&:email).join(", ")
            when "insurance_responsibles" then users.select{|user| user.is_insurance?}.collect(&:email).join(", ")
            else "committee@bathlarp.co.uk"
        end

        respond_to do |format|
            if @email.deliver
                flash[:notice] = 'Email sent.'
                format.html { redirect_to action: :new }
            else
                format.html { render :action => "new" }
            end
        end
    end
    
    private
        def email_params
            params.require(:contact_form).permit(:subject, :message)
        end
    
end