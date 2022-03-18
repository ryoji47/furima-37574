class BuysController < ApplicationController
  before_action :authenticate_user!, only: :index
  before_action :item_post, only: :index

  def index
    
  end

  def create
    
  end
  
  private

  def item_post
    redirect_to root_path if @item.user.id == current_user.id
  end
end
