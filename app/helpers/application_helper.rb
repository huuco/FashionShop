module ApplicationHelper
  def index_for_list object, counter
    ((object.current_page - 1)  * object.limit_value) + counter + 1
  end

  def total_cart products
    @total = 0
    products.each do |product,quantity|
      @total+=product.price*quantity
    end
    @total
  end

end
