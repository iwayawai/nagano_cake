class Public::OrdersController < ApplicationController
  
 def new
  @order=Order.new
 end
 
 def create
  @cart_items=current_customer.cart_items.all
  @order= current_customer.orders.new(order_params)
  @order.member_id = current_member.id
  @order.save
 end 
  
 def confirm
  @order = Order.new(order_params)
  
  if params[:order][:select_address]=="0"
   @order.postal_code=current_customer.postal_code
   @order.address=current_customer.address
   @order.name=current_customer.first_name + current_customer.last_name
   
  elsif params[:order][:select_number] == "1"
   @address = Address.find(params[:order][:address_id])
   @order.postal_code=@address.postal_code
   @order.address=@address.address
   @order.name=@address.name
   
  elsif params[:order][:select_address] =="2"
   @order.postal_code=params[:order][:postal_code]
   @order.address=params[:order][:address]
   @order.name=params[:order][:name]
   
  else
    render 'new'
  end

 end
  
   @cart_items = current_member.cart_items.all
   @order.member_id = current_member.id
   @total = @cart_items.inject(0) {|sum,item| sum + item.sum_of_price }
  end 

 
 private
  def order_params
  params.require(:order).permit(:customer_id,:postal_code,:address,:name,:payment_method,:total_payment,:shipping_cost,:status)
  end 


