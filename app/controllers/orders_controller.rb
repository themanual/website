class OrdersController < ApplicationController

  def update
    product = Shoppe::Product.find_by_permalink!(params[:permalink])
    current_order.order_items.add_item(product, 1)
    redirect_to basket_path
  end

  def show

  end
end
