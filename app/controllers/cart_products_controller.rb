class CartProductsController < ApplicationController
  before_action :set_cart

  def create
    cart_product = @cart.cart_products.create(cart_product_params)

    render json: cart_product, status: :created
  end

  def destroy
    cart_product = @cart.cart_product.find(params[:id])
    cart_product.destroy

    head :no_content
  end

  def private set_cart
    @cart = Cart.find(params[:cart_id])
  end

  def private cart_product_params
    params.permit(:card_id, :product_id)
  end
end
