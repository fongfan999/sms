Rails.application.routes.draw do
  get 'rule/index'

  namespace :admin do
    root 'application#index'
    # get 'statistics/index'

    resources :klasses, except: [:show]
    resources :students, only: [:index, :destroy] do
      collection do
        get :search
        post :search
      end
    end
    resources :rules, only: [:index, :edit, :update] do
      collection do
        get :edit_ability
        post :update_ability
      end
    end
    resources :statistics, only: [:index]
    resources :teachers, except: [:show] do
      # collection do
      #   get :search
      #   post :search
      # end
    end
  end

  devise_for :users
  root 'welcome#index'
  get "rule" => "rule#index"
  resources :klasses, only: [:show] do
    resources :students, except: [:index, :destroy]

    resources :semesters, only: [] do
      resources :courses, only: [] do
        resources :details, only: [:index, :edit, :update] do
          member do
            patch :reset
          end

          collection do
            get :edit_all
            post :update_all

            patch :reset_all
          end
        end
      end
    end
  end

  resources :teachers, only: [:show]

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
