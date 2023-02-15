class Public::ItemsController < ApplicationController
  
def index
  @items=Item.all
  @item_page=Item.page(params[:page])
end

def show
  @item=Item.find(params[:id])
  @cart_item=CartItem
end

end 