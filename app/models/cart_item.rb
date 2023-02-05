class CartItem < ApplicationRecord
  belongs_to :item
  belongs_to :customer
  
  
  def add_tax_price
    (self.price * 1.1).round
  end
  
  def sum_of_price
      cart_item.add_tax_price*amount
  end
    
    
end
