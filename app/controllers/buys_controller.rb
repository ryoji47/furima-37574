class BuysController < ApplicationController
  before_action :authenticate_user!, only: :index
  before_action :set_item, only: [:create, :index]
  before_action :item_post, only: :index
  
  def index
    @buy_order = BuyOrder.new
  end

  def create
    @buy_order = BuyOrder.new(buy_params)
    if @buy_order.valid?
      pay_item
      @buy_order.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def buy_params
    params.require(:buy_order).permit(:post_code, :prefecture_id, :city, :address, :building_name, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def item_post
    if @item.user.id == current_user.id
      redirect_to root_path 
    elsif @item.buy.present?
      redirect_to root_path
    end
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = "sk_test_474e2ee4127ca83f3de8d1a9"  
    Payjp::Charge.create(
      amount: @item.price,
      card: buy_params[:token],    
      currency: 'jpy'                 
    )
  end
end
