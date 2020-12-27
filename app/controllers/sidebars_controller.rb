class SidebarsController < ApplicationController
    before_action :check_admin_or_committee_role

    def edit
        @categories = SidebarCategory.order(:order)
    end
end

