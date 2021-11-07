class GetProductsService < ApplicationService
  attr_reader :filtering
  attr_reader :pagination

  def initialize(filtering, pagination)
    @filtering = filtering
    @pagination = pagination
  end

  def call
    errors = validate_parameters
    return OpenStruct.new({success?: false, errors: errors}) if errors.present?

    filtered_products = filter_products
    paginated_products = paginate_products(filtered_products)
    OpenStruct.new({success?: true, payload: paginated_products})
  end

  private def validate_parameters
    errors = []

    if @filtering
      if @filtering[:category]
        if @filtering[:category][:name].blank?
          errors << "Missing category name"
        end
      elsif @filtering[:price]
        if @filtering[:price][:from].blank? && @filtering[:price][:to].blank?
          errors << "Filtering by price required at least one range parameter (from or to)"
        end
      else
        errors << "Unsupported filtering attribute"
      end
    end
    
    if @pagination
      if Product.page(@pagination[:page]).out_of_range?
        errors << "Provided page is out of range"
      end
    end
  end

  private def filter_products
    products = Product.all
    if @filtering && @filtering[:category]
      category = Category.find_by(name: @filtering[:category][:name])
      products = category.products
    end

    if @filtering && @filtering[:price]
      from = @filtering[:price].fetch(:from, 0)
      to = @filtering[:price].fetch(:to, 10000)
      products = products.filter_by_price(from, to)
    end

    products
  end

  private def paginate_products(products)
    return products.page(@pagination[:page]) if @pagination && @pagination[:page]
    
    products.page(1)
  end
end