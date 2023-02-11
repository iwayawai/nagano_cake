class Order < ApplicationRecord
  has_many :order_items
  belongs_to :customer
  
  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status:{ waiting_for_payment: 0, payment_confirmation:1, in_production:2, preparing_to_ship:3, sent:4 }
  
 
  def get_amount
      amount=0
      order_items.each do |order_item|
      amount += order_item.amount
    end 
    amount
  end 
  
  def get_image
     unless image.attached?
        file_path= Rails.root.join('app/assets/images/no_image.jpg')
        image.attach(io: File.open(file_path), filename:'default-image.jpg', content_type: 'image/jpeg')
     end 
     image
  end 
end
