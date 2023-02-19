class SidebarCategoriesController < ApplicationController
    before_action :check_admin_or_committee_role

    def new
        @category = SidebarCategory.new
        respond_to do |format|
            format.js
        end
    end

    def edit
        @category = SidebarCategory.find( params[:id] )
        respond_to do |format|
            format.js
        end
    end

    def create
        @category = SidebarCategory.new( sidebar_category_params )
        @category.order = SidebarCategory.next_order
        if @category.save
            @categories = SidebarCategory.order(:order)
            render :update_sidebar
        else
            respond_to do |format|
                format.js { render :new }
            end
        end
    end

    def update
        @category = SidebarCategory.find( params[:id] )
        if @category.editable
            if @category.update( sidebar_category_params )
                @categories = SidebarCategory.order(:order)
                render :update_sidebar
            else
                respond_to do |format|
                    format.js { render :edit }
                end
            end
        else
            flash[:error] = "This category cannot be edited."
            reload_page
        end
    end

    def destroy
        @category = SidebarCategory.find( params[:id] )
        if @category.editable
            if @category.destroy
                SidebarCategory.fix_category_order
                SidebarEntry.remove_orphans :category_id => @category.id
                @categories = SidebarCategory.order(:order)
                @no_dialog = true
                render :update_sidebar
            else
                flash[:error] = "Failed to delete category."
                reload_page
            end
        else
            flash[:error] = "This category cannot be deleted."
            reload_page
        end
    end

    def move_up
        selected_category = SidebarCategory.find( params[:id] )
        target_category = SidebarCategory.where('"order" < ?', selected_category.order).order(:order).last
        
        if target_category
            selected_category.order, target_category.order = target_category.order, selected_category.order
            selected_category.save
            target_category.save
            @no_dialog = true
            @categories = SidebarCategory.order(:order)
            render :update_sidebar
        else
            head :ok
        end
    end

    def move_down
        selected_category = SidebarCategory.find( params[:id] )
        target_category = SidebarCategory.where('"order" > ?', selected_category.order).order(:order).first

        if target_category
            selected_category.order, target_category.order = target_category.order, selected_category.order
            selected_category.save
            target_category.save
            @no_dialog = true
            @categories = SidebarCategory.order(:order)
            render :update_sidebar
        else
            head :ok
        end
    end
    
    protected
    
        def sidebar_category_params
            params.require(:sidebar_category).permit(:name, :order, :show_for_non_users, :show_for_admin_users_only, :editable, :always_open )
        end
end

