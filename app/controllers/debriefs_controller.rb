class DebriefsController < ApplicationController
    before_action :authenticate_user!
    before_action :find_game
    before_action :find_debrief, :except => [ :new_gm, :new_monster, :new_player, :create ]
    before_action :check_can_edit_game
    before_action :check_ajax
    before_action :check_game_not_closed

    def new_gm
        @debrief = @game.debriefs.build
        respond_to do |format|
            format.js { render :new_gm }
        end
    end

    def new_monster
        @debrief = @game.debriefs.build
        respond_to do |format|
            format.js { render :new_monster }
        end
    end

    def new_player
        @debrief = @game.debriefs.build
        @debrief.player_debrief = true
        respond_to do |format|
            format.js { render :new_player }
        end
    end

    def create
        debrief_type = params[:debrief_type]
        
        case
        when debrief_type == "GM" then 
          @debrief = @game.debriefs.build(debrief_monster_params)
          create_gm
        when debrief_type == "Monster" then 
          @debrief = @game.debriefs.build(debrief_monster_params)
          create_monster
        when debrief_type == "Player" then 
          @debrief = @game.debriefs.build(debrief_player_params)
          create_player
        else unknown_debrief_type
        end
    end

    def edit_gm
        respond_to do |format|
            format.js
        end
    end

    def edit_monster
        respond_to do |format|
            format.js
        end
    end
    
    def edit_player
        @debrief.player_debrief = true
        respond_to do |format|
            format.js
        end
    end

    def update
        debrief_type = params[:debrief_type]
        
        case
        when debrief_type == "GM" then update_gm
        when debrief_type == "Monster" then update_monster
        when debrief_type == "Player" then update_player
        else unknown_debrief_type
        end
    end

    def destroy
        @debrief.destroy
        update_game_display
    end

    protected
    
        def debrief_monster_params
            params.require(:debrief).permit(:game_id, :user_id, :base_points, :points_modifier, :remarks)
        end
        
        def debrief_player_params
            params.require(:debrief).permit(:game_id, :user_id, :character_id, :base_points, :points_modifier, :remarks, :money_modifier, :loot, :deaths, :character_attributes => [:id, :gm_notes])
        end
        
        def find_game
            @game = Game.find(params[:game_id])
        end
        
        def find_debrief
            @debrief = Debrief.find(params[:id])
        end
        
        def check_can_edit_game
            @game.is_editable_by? current_user
        end
        
        def check_game_not_closed
            !@game.is_debrief_finished?
        end
        
        def create_gm
            if params[:user_selected] == "true"
                if @debrief.save
                    @game.gamesmasters << @debrief.user
                    update_game_display
                else
                    @withname = true
                    respond_to do |format|
                        format.js { render :new_gm }
                    end
                end
            else
                if @debrief.valid?
                    @withname = true
                    respond_to do |format|
                        format.js { render :new_gm }
                    end
                else
                    @debrief.user_id = nil
                    @withname = false
                    respond_to do |format|
                        format.js { render :new_gm }
                    end
                end
            end
        end
        
        def create_monster
            if params[:user_selected] == "true"
                if @debrief.save
                    update_game_display
                else
                    @withname = true
                    respond_to do |format|
                        format.js { render :new_monster }
                    end
                end
            else
                if @debrief.valid?
                    @withname = true
                    respond_to do |format|
                        format.js { render :new_monster }
                    end

                else
                    @debrief.user_id = nil
                    @withname = false
                    respond_to do |format|
                        format.js { render :new_monster }
                    end
                end
            end
        end
        
        def create_player
            @debrief.player_debrief = true
            if params[:user_selected] == "true" and params[:character_selected] == "true"
                if @debrief.save
                    update_game_display
                else
                    respond_to do |format|
                        format.js { render :new_player }
                    end
                end
            elsif params[:user_selected] == "true"
                if @debrief.valid?
                    respond_to do |format|
                        format.js { render :new_player }
                    end
                else
                    @debrief.character_id = nil
                    respond_to do |format|
                        format.js { render :new_player }
                    end
                end
            else
                if @debrief.valid?
                    respond_to do |format|
                        format.js { render :new_player }
                    end
                else
                    @debrief.user_id = nil
                    respond_to do |format|
                        format.js { render :new_player }
                    end
                end
            end
        end
        
        def update_gm
            if @debrief.update(debrief_monster_params)
                update_game_display
            else
                respond_to do |format|
                    format.js { render :edit_gm}
                end
            end
        end
        
        def update_monster
            if @debrief.update(debrief_monster_params)
                update_game_display
            else
                respond_to do |format|
                    format.js { render :edit_monster }
                end
            end
        end
        
        def update_player
            @debrief.player_debrief = true
            if @debrief.update(debrief_player_params)
                update_game_display
            else
                respond_to do |format|
                    format.js { render :edit_player }
                end
            end
        end
        
        def update_game_display
            render :update_game
        end
        
        def unknown_debrief_type
            render :update do |page|
                flash[:error] = "Unknown debrief type."
                page.redirect_to games_path
            end
        end
end
