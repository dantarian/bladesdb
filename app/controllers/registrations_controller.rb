class RegistrationsController < Devise::RegistrationsController
    prepend_before_action :check_captcha, only: [:create]

    def after_update_path_for(resource)
        user_profile_path
    end

    def sign_up_params
        params.require(:user).permit(:name, :username, :email, :password, 
            :password_confirmation, :over18, :accept_terms_and_conditions)
    end

    private
        def check_captcha
            unless verify_recaptcha
                self.resource = resource_class.new sign_up_params
                resource.validate
                resource.errors.add(:base, :invalid, message: "Please confirm you are not a robot.")
                set_minimum_password_length
                respond_with_navigational(resource) { render :new }
            end
        end
end