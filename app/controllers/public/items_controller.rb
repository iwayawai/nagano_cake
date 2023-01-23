class Public::ItemsController < ApplicationController
  belongs_to :genre
  has_many :order_items, dependent: :destroy
  has_many :cart_items, dependent: :destroy
end
