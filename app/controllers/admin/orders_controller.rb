class Admin::OrdersController < ApplicationController
  
  def update
   @order=Order.find(params[:id])
   @order_items=OrderItem.where(order_id: params[:id])
  if @order.update(order_params)
     @order_items.update_all(making_status: 1) if @order.status == "payment_confirmation"
  end
  redirect_to admin_order_path(@order)
  end 
  
  def index
   @orders=Order.page(params[:page])
  end 
  
  def show
   @order=Order.find(params[:id])
   @total=@order.order_items.inject(0) { |sum, item| sum + item.sum_of_price }
  end 
  
  private
  def order_params
  params.require(:order).permit(:customer_id,:postal_code,:address,:name,:payment_method,:total_payment,:shipping_cost,:status)
  end 
end 
