class ItemsController < ApplicationController
  before_action :move_to_index, except: [:index, :show]

  def index
    @items = Item.limit(3).order('created_at DESC').where("buyer_id is NULL")
    @mens_items = Item.where(category_id: 196..326).limit(3).order('created_at DESC').where("buyer_id is NULL")
    @ladies_items = Item.where(category_id: 1..195).limit(3).order('created_at DESC').where("buyer_id is NULL")
  end

  def new
    @item = Item.new
    @item.images.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path, notice: "登録が完了しました"
    else
      render :new
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    item = Item.find(params[:id])
    if item.seller_id == current_user.id
      if item.update(item_params)
      redirect_to item_path(item.id), notice: '商品を更新しました'
      else
        redirect_to edit_item_path, notice: '更新に失敗しました'
      end
    else
      redirect_to item_path(item.id)
    end
  end

  def destroy
    item = Item.find(params[:id])
    if item.seller_id == current_user.id
      item.destroy
    else
      redirect_to item_path(params[:id])
    end
  end

  def show
    @item = Item.includes([:seller, :images, :category, :comments]).find(params[:id])
    @comment = Comment.new
    @comments = @item.comments.includes(:user)
  end

  def set_parents
    @parents  = Category.where(ancestry: nil)
  end

  def set_children
    @children = Category.where(ancestry: params[:parent_id])
  end

  def set_grandchildren
    @grandchildren = Category.where('ancestry LIKE ?', "%/#{params[:child_id]}")
  end

  private
  def item_params
    params.require(:item).permit(:name, :detail, :category_id, :condition_id, :fee_id, :prefecture_id, :shipping_id, :price, :brand, images_attributes: [:img,:_destroy,:id]).merge(seller_id: current_user.id)
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end
end