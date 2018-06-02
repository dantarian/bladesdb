# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
    include ActionView::Helpers::JavaScriptHelper
    helper :all # include all helpers, all the time
    protect_from_forgery # See ActionController::RequestForgeryProtection for details

    before_filter :set_cache_buster
    before_filter :configure_permitted_devise_parameters, if: :devise_controller?
    before_filter :redirect_to_terms_and_conditions_page,
                  if: Proc.new { current_user && !current_user.latest_terms_and_conditions_accepted? },
                  unless: :viewing_terms_and_conditions?

    add_flash_types :notice, :warning, :alert, :error

    def set_cache_buster
        response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
        response.headers["Pragma"] = "no-cache"
        response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
    end

    def page_not_found
        @status = 404
        handle_error
    end

    def server_error
        @status = 500
        handle_error
    end

    protected

        def check_ajax
            unless request.xhr?
                respond_to do |format|
                    format.html {
                        flash[:error] = I18n.t("failure.inaccessible_url")
                        redirect_to @character
                    }
                end
            end
        end

        def check_administrator_role
            unless current_user and current_user.is_admin?
                permission_denied
            end
        end

        def check_admin_or_committee_role
            unless current_user and (current_user.is_admin? or current_user.is_committee?)
                permission_denied
            end
        end

        def check_admin_or_character_ref_role
            unless current_user and (current_user.is_admin? or current_user.is_character_ref?)
                permission_denied
            end
        end

        def check_character_ref_role
            unless current_user and current_user.is_character_ref?
                permission_denied
            end
        end

        def check_committee_role
            unless current_user and current_user.is_committee?
                permission_denied
            end
        end

        def check_active_member
            unless current_user and current_user.approved?
                permission_denied
            end
        end

        def login_prohibited
            if current_user
                permission_denied(I18n.t("failure.role_permission_denied"))
            end
        end

        # Redirect as appropriate when an access request fails due to lack of permissions.
        def permission_denied(message = nil)
            message ||= I18n.t("failure.permission_denied")
            respond_to do |format|
                format.any( :html, :js ) do
                    http_referer = session[:refer_to]
                    if http_referer.nil?
                        store_referer
                        http_referer = ( session[:refer_to] || root_path )
                    end
                    flash[:error] = message
                    unless http_referer.starts_with?( root_path )
                        session[:refer_to] = nil
                        if request.xhr?
                            render :js => "window.location = #{escape_javascript(root_path)}"
                        else
                            redirect_to root_path
                        end
                    else
                        redirect_to_referer_or_default( root_path )
                    end
                end
                format.any( :json, :xml ) do
                    headers[ "Status" ] = "Unauthorized"
                    headers[ "WWW-Authenticate" ] = %(Basic realm="Web Password")
                    render :text => message, :status => '401 Unauthorized'
                end
            end
        end

        # Store the HTTP referer property.
        def store_referer
            session[:refer_to] = request.env["HTTP_REFERER"]
        end

        # Redirect to the URI in the HTTP referer property, or to the passed default.
        def redirect_to_referer_or_default( default )
            if request.xhr?
                render :js => "window.location = '#{j(session[:refer_to] || default)}'"
            else
                redirect_to( session[:refer_to] || default )
            end
            session[:refer_to] = nil
        end

        def redirect_to_terms_and_conditions_page
          unless request.xhr?
            session[:original_target] = request.url
            redirect_to terms_and_conditions_user_path(current_user.id)
          end
        end

        def viewing_terms_and_conditions?
          request.url.ends_with?(terms_and_conditions_user_path(current_user.id)) ||
            request.url.ends_with?(accept_terms_and_conditions_user_path(current_user.id)) ||
            request.url.ends_with?(reject_terms_and_conditions_user_path(current_user.id)) ||
            request.url.ends_with?(reject_terms_and_conditions_and_accept_suspension_user_path(current_user.id))
        end

        def reload_page
            render :js => "location.reload(true);"
        end

        def redirect_by_javascript_to(url)
            render :js => "window.location = '#{escape_javascript url}'"
        end

        def configure_permitted_devise_parameters
            devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :name, :email, :password, :password_confirmation, :over18, :accept_terms_and_conditions) }
            devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :name, :email, :password, :password_confirmation, :current_password, :state, :mobile_number, :contact_name, :contact_number, :medical_notes, :notes) }
        end

    private

        def handle_error
            respond_to do |format|
                format.html { render template: 'error/genericerror', status: @status }
                format.all { render nothing: true, status: @status }
            end
        end

end
