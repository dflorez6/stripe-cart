class CheckoutController < ApplicationController
  require 'stripe'

  def create
    # Setting up a Stripe Session for payment
    @session = Stripe::Checkout::Session.create(
      # TODO: If using Devise, this will send logged_in user's info (stripe_customer_id) to Stripe, instead of creating a new customer with each transaction
      # customer: current_user.stripe_customer_id,

      payment_method_types: ['card'],

      # For only 1 item
      # line_items: [{
      #                price: product.stripe_price_id,
      #                description: description,
      #                quantity: 1
      #              }],

      # For multiple items
      line_items: @cart.collect { |item| item.to_builder.attributes! },
      mode: 'payment',

      #TODO: ?session_id={CHECKOUT_SESSION_ID} this will pass Stripe Session_Id to the URL as params, in order to be
      # used later on to retrieve data from Stripe transaction (for ex: payment intent, line items, etc). Could be used to
      # present a success view to the user with a summary of the transaction / purchase.
      # to retrieve data, review https://www.youtube.com/watch?v=mosADW_yQek
      success_url: checkout_success_url + "&session_id={CHECKOUT_SESSION_ID}",
      cancel_url: checkout_cancel_url
    )

    respond_to do |format|
      format.js
    end
  end

  def success
    if params[:session_id].present?
      # Empty Cart
      # TODO: Fix reload / refresh page to clear cart counter
      session[:cart] = []

      # Retrieve Stripe Checkout Session Data
      @session_with_expand = Stripe::Checkout::Session.retrieve({ id: params[:session_id], expand: ["line_items"] })
      @session_with_expand.line_items.data.each do |line_item|
        product = Product.find_by(stripe_product_id: line_item.price.product)
      end

      # flash[:success] = "Successful Purchase"
    else
      redirect_to checkout_cancel_path
    end
  end

  def cancel

  end

end
