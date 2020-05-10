class ItemsController < ApplicationController
  GROUP_ITEM_STATUS = 100
  GROUP_ITEM_POSTAGE = 101
  GROUP_ITEM_DELIVERY_TIME = 102

  def index   
    @items = Product.all.includes(:user)
  end
  def new
    begin
      @item = Product.new
      @error_messages = ""
      set_default_value
    rescue => exception
      redirect_to root_path
    end
  end
  def create
    begin
      brand_id = Brand.find_by(name: product_params[:brand_name])
      brand_id = "" unless brand_id
      @item = Product.new(product_params)
      @error_messages = ""
      if product_params[:product_images_attributes].nil?
        @error_messages = "画像を選択してください"
      end
      if @item.valid? && @error_messages.empty?
        if @item.save
          redirect_to root_path
        else
          set_default_value
          render :new
        end
      else
        set_default_value
        render :new
      end
    rescue => exception
      @item = Product.new
      @error_messages = "例外処理が発生しました"
      set_default_value
      render :new
    end
  end

  def show
    @product = Product.find(params[:id])
    @grandchild = Category.find(@product[:category_id])
    @children = Category.find(@grandchild[:parent_id])
    @parent = Category.find(@children[:parent_id])
    @prefecture = Prefecture.find(@product[:prefecture_id])
    @status = Code.find_by(group_id: GROUP_ITEM_STATUS, code_id: @product[:status])
    @delivery = Code.find_by(group_id: GROUP_ITEM_DELIVERY_TIME, code_id: @product[:delivery_time_code])
    @postage = Code.find_by(group_id: GROUP_ITEM_POSTAGE, code_id: @product[:postage_code])
    @image = ProductImage.find_by(product_id: params[:id]) 
    @images = ProductImage.where(product_id: @product[:id])
    @like = Like.new
  end

  def destroy
    @product = Product.find(params[:id])
      if @product.user_id == current_user.id
        @product.destroy
      end
  end

  private
  def product_params
    params.require(:product).permit(
      :name,
      :explanation,
      :category_id,
      :brand_name,
      :size,
      :status,
      :postage_code,
      :prefecture_id,
      :delivery_time_code,
      :price,
      product_images_attributes: [:image_name]
      ).merge(user_id:1)
      #).merge(user_id:current_user.id)
  end
  
  def set_default_value
    @item_explanation_placeholder = "商品の説明（必須）\r\n（色、素材、重さ、定価、注意点など）\r\n\r\n例）2010年頃に1万円で購入したジャケットです。ライトグレーで傷はありません。あわせやすいのでおすすめです。"
    @item.product_images.build
    @statuses = Code.group_search(GROUP_ITEM_STATUS)
    @postages = Code.group_search(GROUP_ITEM_POSTAGE)
    @delivery_times = Code.group_search(GROUP_ITEM_DELIVERY_TIME)
    @prefectures = Prefecture.all
  end
end

