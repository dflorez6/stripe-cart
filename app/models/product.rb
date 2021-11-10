class Product < ApplicationRecord

  after_create do
    # After User is created (via Devise), create User in Stripe and update ActiveRecord User object to add stripe_customer_id (THIS SHOULD GO IN THE USER MODEL)
    # customer = Stripe::Customer.create(emaiL: email)
    # update(stripe_customer_id: customer.id)

    # After Product object is created, access Stripe API to add product & product price, then update object in db with Stripe product_id & price_id
    product = Stripe::Product.create(name: name)
    price = Stripe::Price.create(product: product, unit_amount: self.price, currency: self.currency)
    update(stripe_product_id: product.id, stripe_price_id: price.id)
  end

  # Update Stripe Price as DB price changes
  after_update :create_and_assign_new_stripe_price, if: :saved_change_to_price?

  def create_and_assign_new_stripe_price
    price = Stripe::Price.create(product: self.stripe_product_id, unit_amount: self .price, currency: self.currency)
    update(stripe_price_id: price.id)
  end


  #====================
  # Validations
  #====================
  validates :name, :price, presence: true
  validates :price, numericality: {greater_than: 0, less_than: 10000000}

  #====================
  # Associations
  #====================


  #====================
  # Scopes
  #====================
  default_scope { order(created_at: :asc) }

  #====================
  # Methods
  #====================
  # THIS SHOULD GO IN THE USER MODEL
  # def to_s # TODO: I don't understand this method yet from video tutorial https://www.youtube.com/watch?v=lqDJ-ko9GO4
  #  email
  # end

  def to_s # TODO: I don't understand this method yet from video tutorial https://www.youtube.com/watch?v=lqDJ-ko9GO4
    name
  end

  #====================
  # Jbuilder (convert to JSON format)
  #====================
  def to_builder
    Jbuilder.new do |product|
      product.price stripe_price_id
      product.quantity 1
    end
  end

end
