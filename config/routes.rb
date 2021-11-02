Rails.application.routes.draw do


  # =========================
  # Root
  # =========================
  root to: 'static_pages#index'

  # =========================
  # Devise
  # =========================

  # =========================
  # Resources
  # =========================
  resources :products do
    collection do
      get :index_admin
    end

    member do
      # post :add_to_cart # TODO: Refactor from controller route to resource route
      # delete :remove_from_cart # TODO: Refactor from controller route to resource route
    end
  end

  # =========================
  # Authorization
  # =========================

  # =========================
  # Controllers
  # =========================
  # Cart
  get '/cart', to: 'products#cart', as: 'cart'
  post 'products/add_to_cart/:id', to: 'products#add_to_cart', as: 'add_to_cart'  # TODO: Refactor from controller route to resource route
  delete 'products/remove_from_cart/:id', to: 'products#remove_from_cart', as: 'remove_from_cart' # TODO: Refactor from controller route to resource route

  # Data Privacy
  get '/terms-of-service', to: 'static_pages#terms_of_service'
  get '/data-deletion', to: 'static_pages#data_deletion'
  get '/privacy-policy', to: 'static_pages#privacy_policy'

  # =========================
  # Mailer
  # =========================
  # match '/contact', to: 'static_pages#contact', via: :post
  # match '/subscribe', to: 'static_pages#subscribe', via: :post
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
