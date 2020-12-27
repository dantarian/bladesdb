class MonsterPointSpendsController < ApplicationController
    before_action :authenticate_user!
    before_action :find_character
    before_action :find_last_monster_point_spend, :only => [:delete]
    before_action :check_own_character
    before_action :check_ajax, :except => [:delete]
    before_action :check_can_spend_points, :only => [:new, :create]
    before_action :check_can_delete_spend, :only => [:delete]

    def new
        @monster_point_spend = MonsterPointSpend.new
        @monster_point_spend.character = @character
        @monster_point_spend.spent_on = Date.today
        respond_to do |format|
            format.js { render :new_date }
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

    def delete
        if @monster_point_spend.delete
            flash[:notice] = "Monster point spend successfully deleted."
            redirect_to @character
        else
            flash[:error] = "Failed to delete monster point spend."
            redirect_to @character
        end
    end

    protected
        def monster_point_spend_params
            params.require(:monster_point_spend).permit(:character_id, :monster_points_spent, :spent_on, :character_points_gained)
        end
    
        def find_character
            @character = Character.find(params[:character_id])
        end
        
        def find_last_monster_point_spend
            @monster_point_spend = @character.last_monster_point_spend
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
            # TODO: Figure out if anything actually needs to go here...
        end
        
        def check_can_delete_spend
            error = case
            when !@monster_point_spend.last_spend?
                I18n.t("character.monster_points.delete_last_spend.not_last_spend")
            when @monster_point_spend.closed_debriefs_after?
                I18n.t("character.monster_points.delete_last_spend.not_with_closed_debrief_after", date: @monster_point_spend.debrief_preventing_change.game.start_date)
            when @monster_point_spend.monster_point_declaration_after?
                I18n.t("character.monster_points.delete_last_spend.not_with_mp_declaration_after", date: @character.user.monster_point_declaration.declared_on)
            when @monster_point_spend.monster_point_adjustment_after?
                I18n.t("character.monster_points.delete_last_spend.not_with_mp_adjustment_after", date: @monster_point_spend.monster_point_adjustment_preventing_change.declared_on)
            when @monster_point_spend.character_point_adjustment_after?
                I18n.t("character.monster_points.delete_last_spend.not_with_cp_adjustment_after", date: @monster_point_spend.character_point_adjustment_preventing_change.declared_on)
            when @monster_point_spend.character.retired?
                I18n.t("character.monster_points.delete_last_spend.not_when_retired")
            when @monster_point_spend.character.recycled?
                I18n.t("character.monster_points.delete_last_spend.not_when_recycled")
            when @monster_point_spend.character.dead?
                I18n.t("character.monster_points.delete_last_spend.not_when_perm_dead")
            end
            
            unless error.nil?
                flash[:error] = error
                redirect_to @character
            end
        end
end
