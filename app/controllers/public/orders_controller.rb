class Public::OrdersController < ApplicationController
  
 def new
  @order=Order.new
 end
 
 def create
  @cart_items=current_customer.cart_items.all
  @order= current_customer.orders.new(order_params)
  @order.customer_id = current_customer.id
  @order.save
  
  current_customer.cart_items.each do |cart_item|
  @order_item=OrderItem.new
  @order_item.order_id=@order.id
  @order_item.item_id=cart_item.item_id
  @order_item.amount=cart_item.amount
  @order_item.price=cart_item.item.add_tax_price
  @order_item.save
 end 
 current_customer.cart_item.destroy_all
 redirect_to complete_orders_path
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
  
   @cart_items =current_customer.cart_items.all
   @total = @cart_items.inject(0) {|sum,item| sum + item.sum_of_price }
  end 

 def index
  @order_items=Order.all
 end 
 
 
 private
  def order_params
  params.require(:order).permit(:customer_id,:postal_code,:address,:name,:payment_method,:total_payment,:shipping_cost,:status)
  end 
 end
 

