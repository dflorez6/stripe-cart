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
    product.price / 100.0
  end

end
