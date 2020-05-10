class ItemsController < ApplicationController
  #他ユーザーの情報は表示しない
  before_action :ensure_correct_user, {only: [:edit,:update]} 
  GROUP_ITEM_STATUS = 100
  GROUP_ITEM_POSTAGE = 101
  GROUP_ITEM_DELIVERY_TIME = 102

  before_action :set_product, only: [:show, :destroy]

  def index   
    @items = Product.all.includes(:user)
  end
  def new
    begin
      @item = Product.new
      @item.product_images.build
      @error_messages = ""
      set_default_value
    rescue => exception
      redirect_to root_path
    end
  end
  def create
    begin
      brand_id = Brand.find_by(name: product_params[:brand_name])
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
          @item.product_images.build
          render :new
        end
      else
        set_default_value
        @item.product_images.build
        render :new
      end
    rescue => exception
      @item = Product.new
      @error_messages = "例外処理が発生しました"
      set_default_value
      render :new
    end
  end
  def edit
    begin
      @item = Product.find(params[:id])
      @error_messages = ""
      set_edit_default_value
    rescue => exception
      redirect_to root_path
    end
  end
  def update
    begin
      brand_id = Brand.find_by(name: product_params[:brand_name])
      @item = Product.find(params[:id])
      @error_messages = ""
      delete_count = 0
      image_length = 0
      is_image_valid = false
      params[:product][:product_images_attributes].each do |p|
        if p[1]["_destroy"] == "1"
          delete_count += 1
        end
        image_length += 1
      end
      if delete_count < image_length
        is_image_valid = true
      end
      if !is_image_valid
        @error_messages = "画像を選択してください"
      end
      if @item.valid?(product_params) && @error_messages.empty?
        if @item.update(product_params)
          redirect_to root_path
        else
          set_edit_default_value
          render :edit
        end
      else
        set_edit_default_value
        render :edit
      end
    rescue => exception
      @item = Product.new
      @error_messages = "例外処理が発生しました"
      set_edit_default_value
      render :edit
    end
  end

  def show
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
    if @product.user_id == current_user.id && @product.destroy
      render 'items/destroy'
    else
      render 'items/failed'
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
      product_images_attributes: [:id,:image_name,:_destroy]
      ).merge(user_id:current_user.id)
  end
  
  def set_default_value
    @item_explanation_placeholder = "商品の説明（必須）\r\n（色、素材、重さ、定価、注意点など）\r\n\r\n例）2010年頃に1万円で購入したジャケットです。ライトグレーで傷はありません。あわせやすいのでおすすめです。"
    @statuses = Code.group_search(GROUP_ITEM_STATUS)
    @postages = Code.group_search(GROUP_ITEM_POSTAGE)
    @delivery_times = Code.group_search(GROUP_ITEM_DELIVERY_TIME)
    @prefectures = Prefecture.all
  end

  def set_edit_default_value
    @item_images = ProductImage.where(product_id: params[:id])
    @first_images = []
    @second_images = []
    @item_images.each_with_index do |image,idx|
      if idx < 5
        @first_images.push(image)
      else
        @second_images.push(image)
      end
    end      
    #カテゴリ情報の取得
    @current_category = Category.find_by(id: @item.category_id)
    @current_child_category = @current_category.parent
    @current_parent_category = @current_child_category.parent
    set_default_value
  end

  def ensure_correct_user
    current_item = Product.find(params[:id])
    if current_item.user_id != current_user.id
      redirect_to root_path
    end
  end

  def set_product
    @product = Product.find(params[:id])
  end
end

