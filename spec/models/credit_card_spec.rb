require 'rails_helper'

describe CreditCard do
  describe '#create' do

    it "user_idがない場合は登録できないこと" do
      credit_card = FactoryBot.build(:credit_card, user_id: nil)
      credit_card.valid?
      expect(credit_card.errors[:user_id]).to include("を入力してください")
    end

    it "customer_idがない場合は登録できないこと" do
      credit_card = FactoryBot.build(:credit_card, customer_id: nil)
      credit_card.valid?
      expect(credit_card.errors[:customer_id]).to include("を入力してください")
    end

    it "card_idがない場合は登録できないこと" do
      credit_card = FactoryBot.build(:credit_card, card_id: nil)
      credit_card.valid?
      expect(credit_card.errors[:card_id]).to include("を入力してください")
    end

    # 検証する際はuserテーブルにuser＿id1を作成しとく
    it '全項目入力して登録できる' do
      credit_card = FactoryBot.build(:credit_card)
      credit_card.valid?
      expect(credit_card).to be_valid
    end

     
  end
end

