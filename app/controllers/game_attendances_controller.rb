class GameAttendancesController < ApplicationController
    before_action :check_ajax
    before_action :find_game_attendance, :except => [:new, :create]


    # GET /game_attendances/new
    # GET /game_attendances/new.xml
    def new
        @game_attendance = GameAttendance.new
        @game_attendance.user_id = current_user.id
        @game_attendance.game_id = params[:game_id]
        respond_to do |format|
            format.js
        end
    end

    # GET /game_attendances/1/edit
    def edit
        respond_to do |format|
            format.js
        end
    end

    # POST /game_attendances
    # POST /game_attendances.xml
    def create
        @game_attendance = GameAttendance.new(game_attendance_params)
        @game = @game_attendance.game
        case
            when params[:state] == "monstering" then
                @game_attendance.monster
            when params[:state] == "not_attending" then
                @game_attendance.stop_attending
            when params[:state] == "undecided" then
                @game_attendance.become_undecided
            when params[:state] == "playing" then
                @game_attendance.request_to_play
            when params[:state] == "attending" then
                @game_attendance.attend
        end

        if @game_attendance.save
            @close_dialog = true
            update_game_display
        else
            respond_to do |format|
                format.js { render :new }
            end
        end
    end

    # PUT /game_attendances/1
    # PUT /game_attendances/1.xml
    def update
        @game = @game_attendance.game

        case
            when (params[:state] == "monstering") && !@game_attendance.monstering? then
                @game_attendance.monster
            when (params[:state] == "not_attending") && !@game_attendance.not_attending? then
                @game_attendance.stop_attending
            when (params[:state] == "undecided") && !@game_attendance.undecided? then
                @game_attendance.become_undecided
            when (params[:state] == "playing") && !@game_attendance.playing? then
                @game_attendance.request_to_play
            when (params[:state] == "attending") && !@game_attendance.attending? then
                @game_attendance.attend
        end

        if @game_attendance.update(game_attendance_params)
            @close_dialog = true
            update_game_display
        else
            respond_to do |format|
                format.js { render :edit }
            end
        end
    end

    def clear_confirm_state
        @game_attendance.request
        @game_attendance.save
        update_game_display
    end

    def confirm
        @game_attendance.confirm
        @game_attendance.save
        UserMailer.play_attendance(@game_attendance).deliver_now
        update_game_display
    end

    def prioritise
        @game_attendance.prioritise
        @game_attendance.save
        update_game_display
    end

    def reject
        @game_attendance.reject
        @game_attendance.save
        UserMailer.play_attendance(@game_attendance).deliver_now
        update_game_display
    end

    protected
        def update_game_display
            render :update_game
        end

        def find_game_attendance
            @game_attendance = GameAttendance.find(params[:id])
        end

        def game_attendance_params
            params.require(:game_attendance).permit(:game_id, :user_id, :want_food, :food_notes, :character_id, :attend_state, :notes)
        end
end
