class ItemsController < ApplicationController
  before_action :find_item, only: [:show, :edit, :update, :destroy, :complete]

  def index
    if user_signed_in?
      @items = Item.where(user_id: current_user.id).order("created_at DESC")
    end
  end
  
  def show
  end

  def new
    @item = current_user.items.build
  end

  def create
    @item = current_user.items.build(item_params)
    if @item.save
      redirect_to root_path, :message => {:success => "Item created"}
    else
      render 'new'  
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to @item, :message => {:success => "Item updated"}
    else
      render 'edit'
    end
  end

  def destroy
    if @item.destroy 
      redirect_to root_path, :message => {:success => "Item deleted"}
    else
      render @item
    end
  end

  def complete
    @item.update_attribute(:completed_at, Time.now)
    redirect_to root_path
  end

  private
    def item_params
      params.require(:item).permit(:title, :description)
    end

    def find_item
      @item = Item.find(params[:id])
    end
end
