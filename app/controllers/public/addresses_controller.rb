class Public::AddressesController < ApplicationController
  
  def new
    @address=Address.new
  end 
  
  def index
    @addresses=Address.all
  end
  
  def create
    @address=Address.new(address_params)
    @address.save
    redirect_to addresses_path
  end 
  
  private
  def address_params
    params.require(:address).permit(:customer_id,:name,:address,:postal_code)
  end 
end
