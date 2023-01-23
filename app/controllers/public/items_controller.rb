class Public::ItemsController < ApplicationController
  belongs_to :genre
  has_many :order_items, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  
  def new
    @item=Item.new
    @genres=Genre.all
  end 
  
  private
  def item_params
    params.require(:item).permit(:genre_id,:name,:introduction,:price,:is_active,:image)
  end
end
