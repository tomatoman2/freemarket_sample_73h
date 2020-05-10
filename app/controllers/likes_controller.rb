class LikesController < ApplicationController
  before_action :set_product, only: [:create, :destroy]
  
  def index
    @user = current_user
    @likes = Like.where(user_id: @user.id)
  end
  
  def create
    @like = current_user.likes.build(product_id: params[:item_id])
    @like.save
    redirect_to item_path(@product)
  end

  def destroy
    @like = Like.find_by(product_id: params[:item_id], user_id: current_user.id)
    @like.destroy  
    redirect_to item_path(@product)
  end

  private
  def set_product
    @product = Product.find(params[:item_id])
  end
end
