class OrdersController < ApplicationController
  GROUP_ITEM_POSTAGE = 100
  GROUP_ITEM_POSTAGE = 101
  GROUP_ITEM_DELIVERY_TIME = 102

  before_action :set_item, only: [:new, :create]


  def new
    begin
      default_card_information
    rescue => exception
      @error_messages = "例外処理が発生しました"
      redirect_to root_path
    end
  end
  
  def create
    begin
      @order = Order.new(order_params)
      if @order.save
        card = CreditCard.find_by(user_id: current_user.id)
        Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
        Payjp::Charge.create(
          amount: @order.product.price,
          customer: card.customer_id, 
          currency: 'jpy' 
        )
        redirect_to index_path 
      else
        render :new
      end
    rescue => exception
      @error_messages = "購入できませんでした"
      params[:id] = order_params[:product_id]
      default_card_information
      render :new
    end
  end


  private 
  def order_params
    params.require(:order).permit(:product_id)
      .merge(user_id:current_user.id)
  end

  def set_item
    @error_messages = ""
  end

  def default_card_information
    @product = Product.find(params[:id])
    @image = ProductImage.find_by(product_id: params[:id])
    @postage = Code.where(group_id: GROUP_ITEM_POSTAGE, code_id:@product.postage_code)
    @address = Address.find_by(user_id: current_user.id)
    @prefecture = Prefecture.find(@address.prefecture_id)
    @order = Order.new
    #CreditCardテーブルは前回記事で作成、テーブルからpayjpの顧客IDを検索
    card = CreditCard.where(user_id: current_user.id).first
    if card.blank?
      #登録された情報がない場合にカード登録画面に移動
      redirect_to new_credit_card_path(product_id:@product.id)
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      #保管した顧客IDでpayjpから情報取得
      customer = Payjp::Customer.retrieve(card.customer_id)
      #保管したカードIDでpayjpから情報取得、カード情報表示のためインスタンス変数に代入
      @default_card_information = customer.cards.retrieve(card.card_id)
    end
  end
end



