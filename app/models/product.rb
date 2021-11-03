class Product < ApplicationRecord

  #====================
  # Associations
  #====================


  #====================
  # Scopes
  #====================


  #====================
  # Methods
  #====================
  def price_with_cents(product)
    price_with_cents = product.price / 100.0
    price_with_cents = price_with_cents
    sprintf('%.2f', price_with_cents) # Helper to display price with 2 digit cents (returned value is a string)
  end

end
