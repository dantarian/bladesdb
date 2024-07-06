class GmContactsController < ApplicationController
    before_action :find_game
    before_action :check_can_edit

    def new
        @email = ContactForm.new
        @email.subject ||= @game.title
    end

    def create
        @email = ContactForm.new(email_params)
        @email.from_user = current_user.name + " <no-reply@bathlarp.co.uk>"
        @email.to_user = @game.gamesmasters.collect(&:email).join(", ")
        @email.subject = "[BathLARP] " + @email.subject

        users = User.includes(:roles).to_a
        
        @email.bcc_list = case params[:radio_type]
            when "monsters" then @game.monsters.collect(&:email).join(", ")
            when "players" then @game.players.collect(&:email).join(", ")
            when "everybody" then @game.monsters.collect(&:email).join(", ") + ", " + @game.players.collect(&:email).join(", ")
            when "attendees" then @game.attendees.collect(&:email).join(", ")
            else "committee@bathlarp.co.uk"
        end

        if params[:character_refs] then
            @email.to_user += ", characterrefs@bathlarp.co.uk"
        end

        if params[:committee] then
            @email.to_user += ", committee@bathlarp.co.uk"
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
