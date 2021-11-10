module ApplicationHelper

  #=====================
  # Flash Messages
  #=====================
  def alert_class(flash_key)
    case flash_key
    when 'notice'
      'alert-success'
    when 'alert'
      'alert-warning'
    when 'warning'
      'alert-warning'
    when 'error'
      'alert-danger'
    when 'success'
      'alert-success'
    else
      'alert-info'
    end
  end
  #=====================
  # Navbar
  #=====================
  # Navbar link will change depending on route
  def get_navbar_link(anchor)
    if current_page?(root_path)
      anchor
    else
      root_path + anchor
    end
  end

  # Sets active class in navbar links
  def is_active?(link_path)
    if current_page?(link_path)
      'active'
    else
      ''
    end
  end

  #=====================
  # Cart
  #=====================
  def product_quantity(product)
    id = product.id
    cart_array = @cart_array

    # Find product Hash by given ID inside cart_array (from session[:cart])
    product_hash_by_id = cart_array.detect {|h| h['id'] == id }
    product_quantity = product_hash_by_id['quantity']

    # Return product quantity from product Hash
    product_quantity
  end

  def subtotal_price(product)
    id = product.id
    cart_array = @cart_array

    # Find product Hash by given ID inside cart_array (from session[:cart])
    product_hash_by_id = cart_array.detect {|h| h['id'] == id }
    quantity = product_hash_by_id['quantity']
    price = product_hash_by_id['price']

    # Calculate subtotal price
    subtotal_price = (quantity * price) / 100.0

    # Return subtotal_price from Hash
    sprintf('%.2f', subtotal_price) # Helper to display price with 2 digit cents (returned value is a string)
  end

  # TODO: Application Helper - After Prospect & Subscriber Mailer+Form+Controller are created uncomment this
  #=====================
  # Contact Form
  #=====================
  def prospect
    # @prospect = Prospect.new
  end

  #=====================
  # Footer
  #=====================
  def subscriber
    # @subscriber = Subscription.new
  end
end
