class CartsController < ApplicationController
  before_action :set_cart, only: [:show, :complete]

  def create
    cart = Cart.create

    render json: CartBlueprint.render(cart), status: :created 
  end

  def show
    cart = Cart.find(params[:id])

    render json: CartBlueprint.render(cart), status: :ok
  end

  def complete
    @cart.destroy

    render json: {message: "Shopping complited"}, status: :ok
  end

  private def set_cart
    @cart = Cart.find(params[:cart_id])
  end
end
