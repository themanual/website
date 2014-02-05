module OrdersHelper
  def buy_link item
    link_to "$#{item.price.to_i}", purchase_path(item.permalink), method: :post, rel: :'no-follow'
  end
end
