class FoodOptionsController < ApplicationController
    before_filter :check_ajax
    before_filter :find_food_options, :except => [:new, :create]

    def new
        @food_option = FoodOption.new
        @food_option.game_id = params[:game_id]
    
        respond_to do |format|
            format.js
        end
    end
  
    def edit
        respond_to do |format|
            format.js
        end
    end
  
    def create
      @food_option = FoodOption.new(food_option_params)
      
      if @food_option.save
          @close_dialog = true
          update_game_display
      else
          respond_to do |format|
              format.js { render :new }
          end
      end
    end
  
    def update
  
        if @gfood_option.update_attributes(food_option_params)
            @close_dialog = true
            update_game_display
        else
            respond_to do |format|
                format.js { render :edit }
            end
        end
    end
  
    def destroy
      @food_option.destroy
      update_game_display
    end
  
    protected
        def food_option_params
            params.require(:food_option).permit(:game_id, :name, :food_category_id, :food_sub_category_id)
        end
        
        def find_food_option
            @food_option = FoodOption.find(params[:id])
        end
        
        def update_game_display
            render :update_game
        end
end
