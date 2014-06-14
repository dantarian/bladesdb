class GameApplicationsController < ApplicationController
    before_filter :authenticate_user!
    before_filter :check_application_owner, :only => [ :edit, :update, :destroy ]
    before_filter :check_admin_or_committee_or_campaign_gm_role, :only => [ :index, :approve ]

    # GET /game_applications
    # GET /game_applications.xml
    def index
        # @game defined by check_admin_or_committee_or_campaign_gm_role().
        @game_applications = @game.game_applications

        respond_to do |format|
            format.html # index.html.erb
            format.xml  { render :xml => @game_applications }
        end
    end

    # GET /game_applications/new
    # GET /game_applications/new.xml
    def new
        @game_application = GameApplication.new
        @game_application.user_id = current_user.id
        @game_application.game_id = params[:game_id]
        
        respond_to do |format|
                format.js
            end

    end

    # GET /game_applications/1/edit
    def edit
        # @game_application defined by check_application_owner().
        respond_to do |format|
            format.js
        end
    end

    # POST /game_applications
    # POST /game_applications.xml
    def create
        @game_application = GameApplication.new(game_application_params)
        @game = @game_application.game
        
        if @game_application.save
            UserMailer.game_application_made(@game_application).deliver
            render :close_dialog_and_update_game
        else
            respond_to do |format|
                format.js { render :new }
            end
        end
    end

    # PUT /game_applications/1
    # PUT /game_applications/1.xml
    def update
        # @game_application defined by check_application_owner().
        @game = @game_application.game
        
        if @game_application.update_attributes(game_application_params)
            UserMailer.game_application_made(@game_application).deliver
            render :close_dialog_and_update_game
        else
            respond_to do |format|
                format.js { render :edit }
            end
        end
    end

    def approve
        # @game defined by check_admin_or_committee_or_campaign_gm_role().
        @game_application = GameApplication.find(params[:id])
        @game.gamesmasters = [ @game_application.user ]
        
        if @game.save
            @game_application.approve
            UserMailer.game_application_approval(@game_application).deliver
            redirect_to event_calendar_path
        else
            flash[:error] = "Failed to set GM."
            render "index", :game_id => @game_application.game.id
        end
    end
    
    # DELETE /game_applications/1
    # DELETE /game_applications/1.xml
    def destroy
        # @game_application defined by check_application_owner().
        @game = @game_application.game
        @game_application.destroy
        UserMailer.game_application_withdrawn(@game_application).deliver
        @game_application = nil
        
        render :update_game
        
    end
    
    private
        def check_application_owner
            @game_application = GameApplication.find(params[:id])
            unless @game_application.user == current_user
                permission_denied
            end
        end
        
        def check_admin_or_committee_or_campaign_gm_role
            @game = Game.find(params[:game_id])
            all_campaign_gms = @game.campaigns.collect {|campaign| campaign.gamesmasters}.flatten
            unless all_campaign_gms.include? current_user
                check_admin_or_committee_role
            end
        end
        
        def game_application_params
            params.require(:game_application).permit(:game_id,:user_id,:details)
        end
end
