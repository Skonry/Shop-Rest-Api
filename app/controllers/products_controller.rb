class ProductsController < ApplicationController
  def index
    result = GetProductsService.call(params[:filtering], params[:pagination])

    if result && result.success?
      render json: ProductBlueprint.render(result.payload), status: :ok
    else
      render json: {errors: result.errors}, status: :bad_request
    end
  end

  def find
    product = Product.find_by! name: params[:product_name]

    render json: ProductBlueprint.render(product), status: :ok

  rescue ActiveRecord::RecordNotFound
    render json: {message: "Product of given name does not exist"}, status: :not_found
  end
end
