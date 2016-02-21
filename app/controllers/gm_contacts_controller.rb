class GmContactsController < ApplicationController
    before_filter :find_game
    before_filter :check_can_edit
    
    def new
        @email = ContactForm.new
        @email.subject ||= @game.title
    end
    
    def create
        @email = ContactForm.new(email_params)
        @email.from_user = current_user.email
        @email.to_user = @game.gamesmasters.collect(&:email).join(", ")
        @email.subject = "[BathLARP] " + @email.subject
        
        users = User.includes(:roles).to_a
        
        @email.bcc_list = case params[:radio_type]
            when "monsters" then @game.monsters.all.collect(&:email).join(", ")
            when "players" then @game.players.all.collect(&:email).join(", ")
            when "everybody" then @game.monsters.all.collect(&:email).join(", ") + ", " + @game.players.all.collect(&:email).join(", ")
            when "attendees" then @game.attendees.all.collect(&:email).join(", ")
            else "committee@pencethren.org"
        end
        
        if params[:character_refs] then 
            @email.to_user += ", characterrefs@pencethren.org"
        end
        
        if params[:committee] then 
            @email.to_user += ", committee@pencethren.org"
        end

        respond_to do |format|
            if @email.deliver
                flash[:notice] = 'Email sent.'
                format.html { redirect_to @game }
            else
                format.html { render :action => "new" }
            end
        end
    end
    
    private
        def email_params
            params.require(:contact_form).permit(:subject, :message)
        end
        
        def check_can_edit
            unless @game.is_editable_by? current_user
                permission_denied
            end
        end
        
        def find_game
            @game = Game.find(params[:game_id])
        end
    
end