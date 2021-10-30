Rails.application.routes.draw do

  get 'static_pages/index'
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

  # =========================
  # Authorization
  # =========================

  # =========================
  # Controllers
  # =========================
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
