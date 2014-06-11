# This controller handles the login/logout function of the site.    
class SessionsController < Devise::SessionsController

    def create
        self.resource = warden.authenticate!(auth_options)
        message = resource.approved? ? :signed_in : :signed_in_unapproved
        set_flash_message(:notice, message) if is_navigational_format?
        sign_in(resource_name, resource)
        respond_with resource, :location => after_sign_in_path_for(resource)
    end

    # def create
        # logout_keeping_session!
        # user = User.authenticate(params[:login], params[:password])
        # if user
            # # Protects against session fixation attacks, causes request forgery
            # # protection if user resubmits an earlier form using back
            # # button. Uncomment if you understand the tradeoffs.
            # # reset_session
            # self.current_user = user
            # new_cookie_flag = (params[:remember_me] == "1")
            # handle_remember_cookie! new_cookie_flag
            # redirect_back_or_default('/')
            # flash[:notice] = "Logged in successfully"
        # else
            # suspended_user = User.authenticate(params[:login], params[:password], :suspended)
            # note_failed_signin(suspended_user)
            # @login       = params[:login]
            # @remember_me = params[:remember_me]
            # render :action => 'new'
        # end
    # end
# 
    # def destroy
        # logout_killing_session!
        # flash[:notice] = "You have been logged out."
        # redirect_back_or_default('/')
    # end

protected
    # Track failed login attempts
    def note_failed_signin(user)
        if user.nil?
            flash[:error] = "Couldn't log you in as '#{params[:login]}'"
            logger.warn "Failed login for '#{params[:login]}' from #{request.remote_ip} at #{Time.now.utc}"
        else
            flash[:error] = "Your account has been suspended. This may be because you haven't paid your membership fee for this year, nor indicated to the BathLARP committee that you wish to continue your membership. Please e-mail the committee if you wish to do this, or if you believe that your account has been suspended in error."
            logger.warn "Attempted login by suspended user '{#{params[:login]}' at #{Time.now.utc}"
        end
    end
    
    def login_required
      
    end
    
    def login_prohibited
        if user_signed_in?
            permission_denied
        end
    end
end
