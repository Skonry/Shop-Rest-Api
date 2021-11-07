class CartProductsController < ApplicationController
  before_action :set_cart

  def create
    cart_product = @cart.cart_products.create(cart_product_params)

    if cart_product.invalid?
      render json: {message: "Validation failed"}, status: :bad_request 
    else    
      render json: cart_product, status: :created
    end
  end

  def destroy
    cart_product = @cart.cart_product.find(params[:id])
    cart_product.destroy

    head :no_content
  end

  private def set_cart
    @cart = Cart.find(params[:cart_id])
  end

  private def cart_product_params
    params.permit(:card_id, :product_id)
  end
end
