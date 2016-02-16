Blades::Application.routes.draw do

  devise_for :users, :controllers => { :sessions => "sessions", :registrations => "registrations" }

  resources :guild_memberships

  resources :messages, :except => [ :index, :show ] do
    member do
      patch     :undelete
      delete  :purge
      get     :move
      patch     :save_move
    end
  end

  resources :boards do
    member do
      patch :move_up
      patch :move_down
      patch :switch_open_or_closed
    end
    
    collection do
      get :admin
      get :mark_read
    end
  end

  resources :transactions
  resources :campaigns

  resources :games do
    member do
      get :edit_ic_brief
      get :edit_ooc_brief
      get :edit_ic_debrief
      get :edit_ooc_debrief
      patch :update_ic_brief
      patch :update_ooc_brief
      patch :update_ic_debrief
      patch :update_ooc_debrief
      get :start_debrief
      patch :confirm_start_debrief
      patch :finish_debrief
      patch :reopen_debrief
      patch :publish_briefs
      get :first_aid_report
    end

    collection do
      get :outstanding_debriefs
    end
    
    resources :game_attendances, :except => [ :index, :show, :destroy ] do
      member do
        patch :clear_confirm_state
        patch :confirm
        patch :prioritise
        patch :reject
      end
    end

    resources :game_applications, :except => [ :show ] do
      member do
        patch :approve
      end
    end

    resources :debriefs, :except => [ :show, :new, :edit, :index ] do
      new do
        get :new_gm
        get :new_player
        get :new_monster
      end

      member do
        get :edit_gm
        get :edit_player
        get :edit_monster
      end
    end

    resources :users, :except => [ :new, :create, :show, :edit, :update, :index, :destroy ] do
      new do
        get :new_gm
        get :new_player
        get :new_monster
        patch :create_gm
        patch :create_player
        patch :create_monster
      end

      resources :characters, :except => [ :new, :create, :show, :edit, :update, :index, :destroy ] do
        new do
          get :new_player
          patch :create_player
        end 
      end
    end
    
    resource :gm_contact, :except => [ :show, :edit, :update, :index, :destroy ]
    
  end

  resources :characters do
    new do
      get :import
      patch :create_import
    end
    
    collection do
    #   get  :merge_select_characters
    #   post :merge_select_data
    #   post :merge
      get :show_all
    end

    member do
      get :edit_name
      get :edit_bio
      get :edit_date_of_birth
      get :edit_notes
      get :edit_player_notes
      get :edit_gm_notes
      get :edit_address
      patch :update_name
      patch :update_bio
      patch :update_date_of_birth
      patch :update_notes
      patch :update_player_notes
      patch :update_gm_notes
      patch :update_address
      patch :reactivate
      patch :retire
      patch :perm_kill
      patch :resurrect
      patch :approve
      patch :reject
      get :edit_rejected
      patch :update_rejected
      get :declare
      patch :save_declaration
      patch :recycle
    end

    resources :death_threshold_adjustments, :except => [ :index, :show, :destroy ] do
      member do
        patch :approve
        patch :reject
        patch :approve_from_approvals
        patch :reject_from_approvals
      end
    end
    resources :character_point_adjustments, :except => [ :index, :show, :destroy ] do
      member do
        patch :approve
        patch :reject
      end
    end
    resources :monster_point_spends, :except => [ :index, :show, :destroy ]
    resources :guild_memberships, :except => [ :index, :show, :destroy ] do
      new do
        post :leave
        post :eject
        post :eject_from_approvals
        get  :branch_change
        post :create_guild_branch_change
        post :make_full
        post :make_full_from_approvals
      end

      member do
        patch :approve
        patch :provisionally_approve
        patch :reject
        patch :approve_from_approvals
        patch :provisionally_approve_from_approvals
        patch :reject_from_approvals
      end
    end

    resources :transactions, :only => [ :new, :create, :destroy ] do
      new do
        get :new_to_character
      end
    end
  end

  resource :sidebar, :only => :edit do
    resources :sidebar_categories, :as => :categories do
      member do
        patch :move_up
        patch :move_down
      end
    end
    resources :sidebar_entries, :as => :entries do
      member do
        patch :move_up
        patch :move_down
      end
    end
  end

  resources :pages do
    member do
      get :home
    end
  end

  resources :users, :except => [ :edit, :update ] do
    collection do
      get  :merge_select_users
      post :merge_select_data
      post :merge
    end

    member do
      patch :suspend
      patch :unsuspend
      delete :purge
      patch :approve
      patch :undelete
      post :resend_activation
      get :monster_points
      get :edit_user_name
      patch :update_user_name
      get :edit_login
      patch :update_login
      get :edit_email
      patch :update_email
      get :edit_mobile_number
      patch :update_mobile_number
      get :edit_emergency_details
      patch :update_emergency_details
      get :edit_general_notes
      patch :update_general_notes
      patch :enable
    end

    resources :monster_point_adjustments, :except => [ :index, :show, :destroy ] do
      member do
        patch :approve
        patch :reject
        patch :approve_from_approvals
        patch :reject_from_approvals
      end
    end
    
    resource :monster_point_declaration, :except => [ :show, :destroy ] do
      member do
        patch :approve
        patch :reject
        patch :approve_from_approvals
        patch :reject_from_approvals
      end
    end

    resource  :account
    resources :roles, :only => [:index] do
      collection do
        post :update
      end
    end
  end

  resource :committee_contact, :except => [ :show, :edit, :update, :index, :destroy ]
  
  root :to => "pages#home"

  get "/event_calendar"   => "games#list_future",        :as => :event_calendar
  get "/past_games/:year" => "games#index",              :as => :past_games
  get "/next_game"        => "games#next_game",          :as => :next_game
  get "/my_characters"    => "characters#my_characters", :as => :my_characters
  get "/monster_points"   => "my_info#monster_points",   :as => :monster_points
  get "/approvals"        => "admin#approvals",          :as => :approvals
  get "/user_profile"     => "users#profile",            :as => :user_profile

  if Rails.env.production?
    get '404', :to => 'application#page_not_found'
    get '422', :to => 'application#server_error'
    get '500', :to => 'application#server_error'
  end

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   get 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   get 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # get ':controller(/:action(/:id))(.:format)'
end
