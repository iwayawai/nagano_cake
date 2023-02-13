class OrderItem < ApplicationRecord
  belongs_to :item
  belongs_to :order
  
  enum making_status:{ cannot_be_manufactured:0, waiting_for_production:1, in_production:2, completion_of_production:3}
  
   def add_tax_price
  (self.price * 1.1).round
  end 

  def sum_of_price
      item.add_tax_price*amount
  end
end
