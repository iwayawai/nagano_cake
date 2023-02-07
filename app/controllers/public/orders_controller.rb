class Public::OrdersController < ApplicationController
  
 def new
   @order=Order.find(params[:id])
 end
 
 private
  def order_params
  params.require(:order).permit(:customer_id,:postal_code,:address,:name,:payment_method,:total_payment,:shipping_cost,:status)
  end 

end
