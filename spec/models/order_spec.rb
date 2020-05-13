require 'rails_helper'

describe Order do
  describe '#create' do

    it "user_idがない場合は登録できないこと" do
      order = FactoryBot.build(:order, user_id: nil)
      order.valid?
      expect(order.errors[:user_id]).to include("を入力してください")
    end

    it "product_idがない場合は登録できないこと" do
      order = FactoryBot.build(:order, product_id: nil)
      order.valid?
      expect(order.errors[:product_id]).to include("を入力してください")
    end

    # 検証する際はProductテーブルのid1作成しとく
    it '全項目入力して登録できる' do
      order = FactoryBot.build(:order)
      order.valid?
      expect(order).to be_valid
    end

  end
end