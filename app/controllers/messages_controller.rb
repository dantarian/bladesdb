class MessagesController < ApplicationController
    before_action :check_admin_or_committee_role, :only => [:purge]
    before_action :check_active_member, :only => [:edit, :create, :update, :delete, :undelete]
    before_action :find_message, :except => [:create]
    before_action :check_can_edit, :only => [:edit, :move, :update, :save_move, :destroy]
    before_action :check_not_deleted, :only => [:edit, :move, :update, :save_move]
    
    # GET /messages/1/edit
    def edit
        respond_to {|format| format.js }
    end

    def move
        respond_to {|format| format.js }
    end

    # POST /messages
    # POST /messages.xml
    def create
        @message = Message.new(message_params)
        @message.user = current_user

        if @message.duplicate?
            page.redirect_to @message.board
        elsif @message.save
            flash[:notice] = 'Message was successfully posted.'
            reload_page
        else
            respond_to {|format| format.js { render :update_form } }
        end
    end

    # PUT /messages/1
    # PUT /messages/1.xml
    def update
        @message.last_edited_by = current_user
        if @message.update(message_params)
            flash[:notice] = "Message was successfully updated."
            reload_page
        else
            respond_to {|format| format.js { render :edit } }
        end
    end
    
    def save_move
        @message.last_edited_by = current_user
        if @message.update(message_params)
            flash[:notice] = "Message was successfully updated."
            redirect_by_javascript_to board_path(@message.board)
        else
            respond_to {|format| format.js { render :move } }
        end
    end

    def undelete
        if not((current_user == @message.user and current_user == @message.last_edited_by) or current_user.is_admin_or_committee?)
            permission_denied
        else
            @message.deleted = false
            @message.last_edited_by = current_user
            @message.save
            
            respond_to do |format|
                format.html { redirect_to @message.board }
                format.xml  { head :ok }
            end
        end
    end

    # DELETE /messages/1
    # DELETE /messages/1.xml
    def destroy
        @message.deleted = true
        @message.last_edited_by = current_user

        @message.save
        
        respond_to do |format|
            format.html { redirect_to @message.board }
            format.xml  { head :ok }
        end
    end
    
    def purge
        @message.destroy

        respond_to do |format|
            format.html { redirect_to @message.board }
            format.xml  { head :ok }
        end
    end
    
    protected
        def message_params
            params.require(:message).permit(:message, :board_id, :character_id, :user_id, :name, :request_uuid, :merge)
        end
    
        def find_message
            @message = Message.find(params[:id])
        end
        
        def find_board
            @board = Message.find(params[:board_id])
        end
        
        def check_can_edit
            permission_denied unless (current_user == @message.user or current_user.is_admin_or_committee?)
        end
        
        def check_not_deleted
            permission_denied if @message.deleted
        end
end
