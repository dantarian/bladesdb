class SidebarsController < ApplicationController
    before_filter :check_admin_or_committee_role

    def edit
        @categories = SidebarCategory.order(:order)
    end
end

