class ProductsController < ApplicationController
  def index
    result = GetProductsService.call(params[:filtering], params[:pagination])

    if result && result.success?
      render json: ProductBlueprint.render(result.payload), status: :ok
    else
      render json: {errors: result.errors}, status: :bad_request
  end
end
