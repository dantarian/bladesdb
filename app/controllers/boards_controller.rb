class BoardsController < ApplicationController
    before_filter :check_admin_or_committee_role, :only => [:admin, :new, :create, :update, :destroy ]
    before_filter :authenticate_user!, :only => [:index, :show]
        
    # GET /boards
    # GET /boards.xml
    def index
      @boards = Board.all
  
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @boards }
      end
    end

    def admin
      @boards = Board.all
  
      respond_to do |format|
        format.html # admin.html.erb
        format.xml  { render :xml => @boards }
      end
    end

    # GET /boards/1
    # GET /boards/1.xml
    def show
        @board = Board.find(params[:id])
        @page = (params[:page] || 1).to_i
        @messages = @board.messages.limit(30).offset((@page - 1) * 30)
        
        # Set up form object for new message.
        @message = Message.new
        @message.board_id = @board.id
        @message.user_id = current_user.id
        @message.request_uuid = `uuidgen`.strip

        # Update last visit.
        current_user.visit(@board)
        
        respond_to do |format|
            format.html # show.html.erb
            format.xml  { render :xml => @board }
        end
    end

    # GET /boards/new
    # GET /boards/new.xml
    def new
        @board = Board.new
        respond_to do |format|
            format.js
        end
    end

    # GET /boards/1/edit
    def edit
        @board = Board.find(params[:id])
        respond_to do |format|
            format.js
        end
    end

    # POST /boards
    # POST /boards.xml
    def create
        @board = Board.new(board_params)
        last_board = Board.last
        @board.order = if last_board then last_board.order + 1 else 1 end

        if @board.save
            update_boards(true)
        else
            respond_to do |format|
                format.js { render :new }
            end
        end
    end

    # PUT /boards/1
    # PUT /boards/1.xml
    def update
        @board = Board.find(params[:id])
        
        if @board.update_attributes(board_params)
            update_boards(true)
        else
            respond_to do |format|
                format.js { render :edit }
            end
        end
    end
    
    # DELETE /boards/1
    # DELETE /boards/1.xml
    def destroy
        @board = Board.find(params[:id])
        @board.destroy
        update_boards        
    end
    
    def move_up
        selected_board = Board.find( params[:id] )
        target_board = Board.where('"order" < ?', selected_board.order).last
        
        if target_board
            selected_board.order, target_board.order = target_board.order, selected_board.order
            selected_board.save
            target_board.save
            update_boards
        else
            render :nothing => true, :status => "ok"
        end
    end

    def move_down
        selected_board = Board.find( params[:id] )
        target_board = Board.where('"order" > ?', selected_board.order).first

        if target_board
            selected_board.order, target_board.order = target_board.order, selected_board.order
            selected_board.save
            target_board.save
            update_boards
        else
            render :nothing => true, :status => "ok"
        end
    end
    
    def mark_read
        Board.all.each do |board|
            current_user.visit(board)
        end
        redirect_to boards_path
    end
    
    private
        def board_params
            params.require(:board).permit(:name, :blurb, :in_character, :campaign_id)
        end
        
        def update_boards(close_dialog = false)
            @boards = Board.all
            respond_to do |format|
                format.js {
                    if close_dialog 
                        render :close_dialog_and_update_boards
                    else
                        render :update_boards
                    end 
                }
            end
        end
end
