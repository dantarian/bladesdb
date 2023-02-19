class SidebarEntriesController < ApplicationController
    before_action :check_admin_or_committee_role

    def new
        @entry = SidebarEntry.new

        if params[:category_id]
            @entry.sidebar_category_id = params[:category_id]
        else
            @entry.parent_entry_id = params[:parent_entry_id]
        end
        
        respond_to do |format|
            format.js
        end
    end

    def edit
        @entry = SidebarEntry.find( params[:id] )
        respond_to do |format|
            format.js
        end
    end

    def create
        @entry = SidebarEntry.new( sidebar_entry_params )
        if @entry.sidebar_category_id
            parent_condition = "sidebar_category_id = ?"
            parent_id = @entry.sidebar_category_id
            parent_container = "entries#{parent_id}"
        else
            parent_condition = "parent_entry_id = ?"
            parent_id = @entry.parent_entry_id
            parent_container = "subentries#{parent_id}"
        end
        last_entry = SidebarEntry.where(parent_condition, parent_id).order(:order).last
        if last_entry
            @entry.order = last_entry.order + 1
        else
            @entry.order = 1
        end
        if @entry.save
            @categories = SidebarCategory.order(:order)
            render :update_sidebar
        else
            respond_to do |format|
                format.js { render :new }
            end
        end
    end

    def update
        @entry = SidebarEntry.find( params[:id] )
        if @entry.editable
            if @entry.update( sidebar_entry_params )
                @categories = SidebarCategory.order(:order)
                render :update_sidebar
            else
                respond_to do |format|
                    format.js { render :edit }
                end
            end
        else
            flash[:error] = "This entry cannot be edited."
            reload_page
        end
    end

    def destroy
        @entry = SidebarEntry.find( params[:id] )
        if @entry.editable
            if @entry.sidebar_category_id
                parent_conditions = [ "sidebar_category_id = ?", @entry.sidebar_category_id ]
            else
                parent_conditions = [ "parent_entry_id = ?", @entry.parent_entry_id ]
            end
            if @entry.destroy
                SidebarEntry.fix_entry_order parent_conditions
                SidebarEntry.remove_orphans :parent_entry_id => @entry.id
                @no_dialog = true
                @categories = SidebarCategory.order(:order)
                render :update_sidebar
            else
                flash[:error] = "Failed to delete entry."
                reload_page
            end
        else
            flash[:error] = "This entry cannot be deleted."
            reload_page
        end
    end

    def move_up
        selected_entry = SidebarEntry.find( params[:id] )
        if selected_entry.sidebar_category_id
            parent_condition = "sidebar_category_id = ?"
            parent_id = selected_entry.sidebar_category_id
        else
            parent_condition = "parent_entry_id = ?"
            parent_id = selected_entry.parent_entry_id
        end
        target_entry = SidebarEntry.where("\"order\" < ? AND #{parent_condition}", selected_entry.order, parent_id).order(:order).last
        
        if target_entry
            selected_entry.order, target_entry.order = target_entry.order, selected_entry.order
            selected_entry.save
            target_entry.save
            @no_dialog = true
            @categories = SidebarCategory.order(:order)
            render :update_sidebar
        else
            head :ok
        end
    end

    def move_down
        selected_entry = SidebarEntry.find( params[:id] )
        if selected_entry.sidebar_category_id
            parent_condition = "sidebar_category_id = ?"
            parent_id = selected_entry.sidebar_category_id
        else
            parent_condition = "parent_entry_id = ?"
            parent_id = selected_entry.parent_entry_id
        end
        target_entry = SidebarEntry.where("\"order\" > ? AND #{parent_condition}", selected_entry.order, parent_id).order(:order).first

        if target_entry
            selected_entry.order, target_entry.order = target_entry.order, selected_entry.order
            selected_entry.save
            target_entry.save
            @no_dialog = true
            @categories = SidebarCategory.order(:order)
            render :update_sidebar
        else
            head :ok
        end
    end
    
    protected
    
        def sidebar_entry_params
            params.require(:sidebar_entry).permit(:page_id, :sidebar_category_id, :parent_entry_id, :url, :editable, :order, :name)
        end
end

