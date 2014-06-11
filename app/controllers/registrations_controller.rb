class RegistrationsController < Devise::RegistrationsController
    def after_update_path_for(resource)
        user_profile_path
    end
end