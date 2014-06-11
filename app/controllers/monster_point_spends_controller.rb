class MonsterPointSpendsController < ApplicationController
    before_filter :authenticate_user!
    before_filter :find_character
    before_filter :find_monster_point_spend, :except => [:new, :create]
    before_filter :check_own_character
    before_filter :check_ajax
    before_filter :check_can_spend_points, :only => [:new, :create]

    def new
        @monster_point_spend = MonsterPointSpend.new
        @monster_point_spend.character = @character
        @monster_point_spend.spent_on = Date.today
        respond_to do |format|
            format.js { render :new_date }
        end
    end

    def edit
        if @character.monster_point_spends.exists? ["spent_on > ?", @monster_point_spend.spent_on]
            flash[:notice] = "You can only edit your most recent monster point spend."
            reload_page
        else
            respond_to do |format|
                format.js { render :edit_date }
            end
        end
    end

    def create
        @monster_point_spend = MonsterPointSpend.new(monster_point_spend_params)
        @monster_point_spend.character = @character
        @monster_point_spend.monster_points_spent = 0 if @monster_point_spend.monster_points_spent.nil?
        
        case params[:commit]
        when "date"
            if @monster_point_spend.valid?
                respond_to do |format|
                    format.js { render :new_spend }
                end
            else
                respond_to do |format|
                    format.js { render :new_date }
                end
            end
        when "points"
            @monster_point_spend.complete = true
            if @monster_point_spend.save
                flash[:notice] = "Monster points successfully spent."
                reload_page
            else
                respond_to do |format|
                    format.js { render :new_spend }
                end
            end
        end
    end

    def update
        case params[:commit]
        when "date"
            @monster_point_spend.spent_on = (params[:monster_point_spend][:spent_on])
            if @monster_point_spend.valid?
                respond_to do |format|
                    format.js { render :edit_spend }
                end
            else
                respond_to do |format|
                    format.js { render :edit_date }
                end
            end
        when "points"
            @monster_point_spend.complete = true
            if @monster_point_spend.update_attributes(monster_point_spend_params)
                flash[:notice] = "Monster points spend successfully updated."
                reload_page
            else
                respond_to do |format|
                    format.js { render :edit_spend }
                end
            end
        end
    end

    protected
        def monster_point_spend_params
            params.require(:monster_point_spend).permit(:character_id, :monster_points_spent, :spent_on, :character_points_gained)
        end
    
        def find_character
            @character = Character.find(params[:character_id])
        end
        
        def find_monster_point_spend
            @monster_point_spend = MonsterPointSpend.find(params[:id])
        end
        
        def check_own_character
            unless @character.user == current_user
                permission_denied
            end
        end
        
        def check_ajax
            unless request.xhr?
                flash[:error] = "The requested URL is not accessible directly."
                reload_page
            end
        end
        
        def check_can_spend_points
            if @character.character_point_adjustments.to_a.any? {|adj| adj.is_provisional? }
                flash[:error] = "You cannot spend monster points on this character until all outstanding character point adjustments have been approved or rejected."
                reload_page
            elsif @character.played_games.to_a.any? {|game| !game.is_debrief_finished? }
                flash[:error] = "You cannot spend monster points on this character until all outstanding debriefs have been finalised."
                reload_page
            end
        end
end
