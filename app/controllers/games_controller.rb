class GamesController < ApplicationController
  
    helper GamesHelper
  
    before_filter :authenticate_user!, :except => [ :index, :list_future ]
    before_filter :check_admin_or_committee_role, :only => [ :new, :create, :destroy ]
    before_filter :find_game, :except => [ :index, :list_future, :new, :create, :outstanding_debriefs, :next_game ]
    before_filter :check_can_edit, :except => [ :index, :list_future, :new, :create, :destroy, :show, :outstanding_debriefs, :next_game, :first_aid_report ]
    before_filter :check_ajax, :except => [ :index, :list_future, :show, :outstanding_debriefs, :next_game, :first_aid_report ]
    before_filter :check_game_not_closed, :except => [ :index, :list_future, :new, :create, :reopen_debrief, :show, :outstanding_debriefs, :next_game ]
    before_filter :check_gm_points_not_overspent, :only => [ :finish_debrief ]
    
    # GET /games
    # GET /games.xml
    def index
        @selected_year = (params[:year] || Game.current_year).to_i
        @games = Game.where("start_date >= ? and start_date <= ?", Date.new(@selected_year, 10, 1), [Date.today, Date.new(@selected_year+1, 10, 1)].min).order(:start_date).includes(:gamesmasters)

        respond_to do |format|
            format.html # index.html.erb
            format.xml  { render :xml => @games }
        end
    end
    
    def list_future
        @games = Game.future_games.includes(:gamesmasters)
            
        respond_to do |format|
            format.html # list_future.html.erb
            format.xml { render xml: @games }
        end
    end
    
    def outstanding_debriefs
        @games = current_user.outstanding_debriefs
        
        respond_to do |format|
            format.html # outstanding_debriefs.html.erb
            format.xml { render xml: @games }
        end
    end

    def show
        respond_to do |format|
            format.html
            format.js
        end
    end
    
    def next_game
        @game = Game.future_games.first()
        if @game.is_debriefable?
            @game = Game.future_games.second()
        end
        respond_to do |format|
            format.html { render :show }
        end
        
    end

    # GET /games/new
    # GET /games/new.xml
    def new
        @game = Game.new
        # Default the date to the next free Sunday.
        @game.start_date = Game.next_free_sunday
        @game.meet_time = Time.parse("11:00").strftime('%H:%M')
        @game.start_time = Time.parse("12:00").strftime('%H:%M')

        respond_to do |format|
            format.js
        end
        
    end

    # GET /games/1/edit
    def edit
        if @game.is_debrief_started?
            display_debrief_dialog(true)
        else
            display_game_dialog
        end
    end
    
    def edit_ic_brief
        display_ic_brief_dialog
    end
    
    def edit_ooc_brief
        display_ooc_brief_dialog
    end
    
    def edit_ic_debrief
        display_ic_debrief_dialog
    end
    
    def edit_ooc_debrief
        display_ooc_debrief_dialog
    end
    
    def start_debrief
        @game.player_money_base ||= 10
        display_debrief_dialog
    end
    
    # POST /games
    # POST /games.xml
    def create
        params[:game][:campaign_ids] ||= []
        params[:game][:gamesmaster_ids] ||= []
        @game = Game.new(game_create_params)

        if @game.save
            @games = Game.future_games
            render :update_calendar
        else
            respond_to do |format|
                format.js { render :new }
            end
        end
    end

    # PUT /games/1
    # PUT /games/1.xml
    def update
        if @game.is_debrief_started?
            update_game { display_debrief_dialog(true) }
        else
            update_game { display_game_dialog }
        end
    end
    
    def update_ic_brief
        update_game { display_ic_brief_dialog }
    end

    def update_ooc_brief
        update_game { display_ooc_brief_dialog }
    end
    
    def publish_briefs
        @game.post_brief(current_user)
        render :briefs_published
    end

    def update_ic_debrief
        update_game { display_ic_debrief_dialog }
    end
    
    def update_ooc_debrief
        update_game { display_ooc_debrief_dialog }
    end
    
    def confirm_start_debrief
        params[:game][:campaign_ids] ||= []
        params[:game][:gamesmaster_ids] ||= []
        @game.setup_debrief

        unless @game.is_debrief_started?
            @game.debrief_started = true
            if @game.update_attributes(game_debrief_params)
                @game.game_attendances.destroy_all
                @game.game_applications.destroy_all
                @game.debriefs.reload
                update_game_display
            else
                display_debrief_dialog
            end
        else
            flash[:error] = "Game debrief already started."
            reload_page
        end
    end

    def finish_debrief
        @game.open = false
        if @game.save
            @no_dialog = true
            @game.post_debrief(current_user)
            update_game_display
        else
            redirect_for_failed_save
        end
    end
    
    def reopen_debrief
        @game.open = true
        if @game.save
            @no_dialog = true
            update_game_display
        else
            redirect_for_failed_save
        end
    end
    
    def destroy
        unless @game.is_debrief_started?
            @game_id = @game.id
            @game.destroy
            render :remove_game
        else
            flash[:error] = "Cannot delete a game once debriefing has started."
            reload_page
        end
    end
    
    def first_aid_report
        respond_to do |format|
            format.html # first_aid_report.html.erb
            format.xml  { render xml: @game }
        end
    end
    
    protected
    
        def game_create_params
            params.require(:game).permit(:title, :lower_rank, :upper_rank, :ic_brief, :ooc_brief, :start_date, :end_date, :meet_time, :start_time, :food_notes, :open, :notes, :non_stats, :attendance_only, {:campaign_ids => []}, {:gamesmaster_ids => []} )
        end
        
        def game_debrief_params
            params.require(:game).permit(:title, :ic_brief, :ooc_brief, :ic_debrief, :ooc_debrief, :player_points_base, :player_money_base, :monster_points_base, {:campaign_ids => []}, {:gamesmaster_ids => []})
        end
        
        def check_can_edit
            unless @game.is_editable_by? current_user
                permission_denied
            end
        end

        def check_game_not_closed
            if @game.is_debrief_finished?
                redirect_for_finished_debrief
            end
        end

        def check_gm_points_not_overspent
            if @game.gm_points_available < 0
                redirect_for_gm_overspend
            end
        end

        def find_game
            @game = Game.find(params[:id])
        end
    
        def update_game
            params[:game][:campaign_ids] ||= []
            params[:game][:gamesmaster_ids] ||= []
            
            if @game.update_attributes(@game.is_debrief_started? ? game_debrief_params : game_create_params )
                update_game_display
            else
                yield
            end
        end

        def update_game_display
            render :update_game
        end

        def display_debrief_dialog(editing = false)
            if editing
                respond_to do |format|
                    format.js { render :edit_debrief }
                end
            else
                respond_to do |format|
                    format.js { render :new_debrief }
                end
            end
        end

        def display_game_dialog
            respond_to do |format|
                format.js { render :edit }
            end
        end
        
        def display_ic_brief_dialog
            respond_to { |format| format.js }
        end

        def display_ooc_brief_dialog
            respond_to { |format| format.js }
        end

        def display_ic_debrief_dialog
            respond_to { |format| format.js }
        end

        def display_ooc_debrief_dialog
            respond_to { |format| format.js }
        end

        def redirect_for_failed_save
            flash[:error] = "Failed to save changes to Game."
            reload_page
        end

        def redirect_for_started_debrief
            flash[:error] = "Game debrief already started."
            reload_page
        end

        def redirect_for_finished_debrief
            flash[:error] = "Game is closed for editing."
            reload_page
        end
        
        def redirect_for_gm_overspend
            flash[:error] = "Cannot finish debrief: Too many GM points allocated."
            reload_page
        end
end
