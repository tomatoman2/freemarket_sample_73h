class CreditCardController < ApplicationController

  require "payjp"

  before_action :set_item, only: [:pay, :new, :show]

  def new
    begin
      card = CreditCard.where(user_id: current_user.id)
      redirect_to action: "show" if card.exists?
    rescue => exception
      redirect_to root_path
    end
  end

  def pay #payjpとCardのデータベース作成を実施します
    # begin
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      if params['payjp-token'].blank?
        redirect_to action: "new"
      else
        customer = Payjp::Customer.create(
        card: params['payjp-token'],
        metadata: {user_id: current_user.id}
        ) 
        @card = CreditCard.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
        if @card.save
          if params[:product_id]
            redirect_to new_order_path(id: params[:product_id])
          else 
            redirect_to user_path(current_user.id)
          end
        end
      end
    # rescue => exception
    #   @error_messages = "登録できませんでした"
    #   render :new 
    # end
  end

  def delete #PayjpとCardデータベースを削除します
    begin
      card = CreditCard.find_by(user_id: current_user.id)
      if card.blank?
      else
        Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
        customer = Payjp::Customer.retrieve(card.customer_id)
        customer.delete
        card.delete
      end
        redirect_to action: "new"
    rescue => exception
      @error_messages = "削除できませんでした"
      set_show_default_value
      render :show
    end
  end

  def show #Cardのデータpayjpに送り情報を取り出します
    set_show_default_value
  end

  private
  def set_item
    @error_messages = ""
  end

  def set_show_default_value #Cardのデータpayjpに送り情報を取り出します
    card = CreditCard.find_by(user_id: current_user.id)
    if card.blank?
      redirect_to action: "new" 
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(card.customer_id)
      @default_card_information = customer.cards.retrieve(card.card_id)
    end
  end

end


