class ItemsController < ApplicationController
  def index
  end

  def new
  end

  def create
    @item = Item.new(set_params)
  end

  def show
    @item = Item.includes([:user, :image, :category]).find(params[:id])
  end

  private
  def set_params
    params.require(:item).permit(:category).merge(user_id: current_user.id)
  end

  def item_params
    params.require(:item).permit(:item_id)
  end

  def set_parents
    @parents  = Category.where(ancestry: nil)
  end

  def set_children
    @children = Category.where(ancestry: params[:parent_id])
  end

  def set_grandchildren
    @grandchildren = Category.where(ancestry: params[:ancestry])
  end

end
