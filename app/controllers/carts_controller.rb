class CartsController < ApplicationController
  before_action :set_cart

  def create
    cart = Cart.create

    render json: CartBlueprint(cart).render, status: :created 
  end

  def show
    cart = Cart.find(params[:id])

    render json: CartBlueprint(cart).render, status: :ok
  end

  def complete
    @cart.destroy

    render json: {message: "Shopping complited"}, status: :ok
  end

  private def set_cart
    @cart = Cart.find(params[:cart_id])
  end
end
