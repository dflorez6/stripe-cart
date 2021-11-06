class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]

  def index
    @products = Product.all
  end

  def show
  end

  def new
    @product = Product.new
  end

  def edit
  end

  def create
    @product = Product.new(product_params)

    # Convert price for Stripe
    price_in_cents(@product)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to index_admin_products_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  #====================
  # Cart
  #====================
  def cart
    total = total_price / 100.0
    @total_price = sprintf('%.2f', total) # Helper to display price with 2 digit cents (returned value is a string)
  end

  def add_to_cart
    id = params[:id].to_i
    quantity = params[:quantity].to_i
    price = params[:price].to_i

    session[:cart] << Hash(id: id, quantity: quantity, price: price) unless session[:cart].include?(id)

    # puts '----->'
    # puts session[:cart]

    redirect_to products_path
  end

  def remove_from_cart
    id = params[:id].to_i
    cart = session[:cart]

    # Deletes Hash with id from cart Array
    cart.delete_if { |h| h['id'] == id }

    redirect_back(fallback_location: cart_path)
  end

  def total_price
    cart_array = @cart_array
    subtotal_prices_array = []

    # Iterates over cart_array and creates a new array of price * quantity (iterating over every product Hash)
    cart_array.each do |product|
      price = product['price']
      quantity = product['quantity']
      subtotal_prices_array << (price * quantity)
    end

    # Sums all subtotal prices to return Total price
    subtotal_prices_array.inject(0, :+)
  end

  #====================
  # Custom Methods
  #====================
  def index_admin
    @products = Product.all
  end

  def price_in_cents(product)
    price = params[:product][:price]
    price = price.to_f
    price_in_cents = price * 100
    price_in_cents = price_in_cents.ceil(1)
    price_in_cents = price_in_cents.to_i
    product.price = price_in_cents
  end

  #====================
  # Private
  #====================
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.require(:product).permit(:name, :description, :image, :price)
  end
end
