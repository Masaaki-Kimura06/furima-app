class ItemsController < ApplicationController
  def index
    @items = Item.includes(:images).order('created_at DESC')
  end

  def new
    @item = Item.new
    @item.images.new
    @categorys = Category.all

  end

  def create
    @item = Item.new(item_params)
    if @item.save!
      redirect_to root_path
    else
      render :new
      binding.pry
    end
  end

  def edit
  end

  def show
    @item = Item.includes([:user, :images, :category]).find(params[:id])
  end

  private
  def item_params
    params.require(:item).permit( :name, :detail, :condition, :postage, :ship_from, :ship_date, :price, :brand, images_attributes: [:img])
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
