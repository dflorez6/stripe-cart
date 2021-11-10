class ApplicationController < ActionController::Base

  protect_from_forgery prepend: true
  # protect_from_forgery with: :exception

  before_action :set_locale
  before_action :initialize_session
  before_action :load_cart
  before_action :cart_array

  # Permit other parameters for devise TODO: Uncomment to permit Devise Additional Fields for Sign Up
  # before_action :configure_permitted_parameters, if: :devise_controller?

  #==============
  # Private Methods
  #==============
  private
  # Use callbacks to share common setup or constraints between actions.

  def initialize_session
    session[:cart] ||= []
  end

  def load_cart
    cart = session[:cart]
    product_ids = []

    # Iterates over cart Session Array, get product_ids from Hash & push them into product_ids Array in order to find Product objects
    cart.each do |item|
      product_id = item['id']
      product_ids << product_id
    end

    @cart = Product.find(product_ids)
  end

  def cart_array
    @cart_array = session[:cart]
  end

  #==============
  # Protected Methods
  #==============
  protected
  def set_locale
    if params[:locale].blank?
      I18n.locale = :'en'
    else
      I18n.locale = params[:locale]
    end
  end

  def default_url_options(options={})
    {:locale => I18n.locale}
  end

  # Permit additional parameters for devise
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, ])
  end

end
