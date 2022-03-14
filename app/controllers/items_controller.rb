class ItemsController < ApplicationController
  before_action :authenticate_user!, only: :new

  def index
    
  end

  def new
    @item = Item.new
  end

  def create
    
  end

  private

  def item_params
    params.require(:item).permit(:name, :image, :explanation, :category_id, :sales_status_id, :postage_id, :prefecture_id, :days_id, :price).merge(user_id: current_user.id)
  end
end
