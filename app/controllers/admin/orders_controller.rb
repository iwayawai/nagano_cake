class Admin::OrdersController < ApplicationController
  
  def index
   @orders=Order.page(params[:page])
  end 
  
  def show
   @order=Order.find(params[:id])
   
   @total=order_items.inject(0) { |sum, item| sum + item.sum_of_price }
  end 
  
  private
  def order_params
  params.require(:order).permit(:customer_id,:postal_code,:address,:name,:payment_method,:total_payment,:shipping_cost,:status)
  end 

end
