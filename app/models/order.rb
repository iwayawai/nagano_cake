class Order < ApplicationRecord
  has_many :order_items
  belongs_to :customer
  
  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status:{ waiting_for_payment: 0, payment_confirmation:1, in_production:2, preparing_to_ship:3, sent:4 }
  
  def add_tax_price
  (self.price * 1.1).round
  end 

  def sum_of_price
      item.add_tax_price*amount
  end
  
  def get_image
     unless image.attached?
        file_path= Rails.root.join('app/assets/images/no_image.jpg')
        image.attach(io: File.open(file_path), filename:'default-image.jpg', content_type: 'image/jpeg')
     end 
     image
  end 
end
