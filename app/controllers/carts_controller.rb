class CartsController < ApplicationController
  def create
    cart = Cart.create

    render :json CartBlueprint(cart).render, status: :created 
  end

  def show
    cart = Cart.find(params[:id])

    render :json CartBlueprint(cart).render, status: :ok
  end
end
