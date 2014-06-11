class MyInfoController < ApplicationController
    before_filter :authenticate_user!
    before_filter :find_current_user

    def monster_points
        respond_to do |format|
            format.html
        end
    end
    
    private
        def find_current_user
            @user = current_user
        end
end
