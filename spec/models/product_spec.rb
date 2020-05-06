require 'rails_helper'
describe Product do
  describe '#create' do
    context 'can save' do
      it '任意項目を空白で登録できる' do
        expect(FactoryBot.build(:product, brand_name: nil,brand_id: nil,size: nil)).to be_valid
      end

      it '全項目入力して登録できる' do
        expect(FactoryBot.build(:product)).to be_valid
      end
    end

    context 'can not save' do
      it 'invalid name' do
        product = FactoryBot.build(:product, name: nil)
        product.valid?
        expect(product.errors[:name]).to include("を入力してください")
      end

      it 'invalid category_id' do
        product = FactoryBot.build(:product, category_id: nil)
        product.valid?
        expect(product.errors[:category_id]).to include("を入力してください")
      end

      it 'invalid price' do
        product = FactoryBot.build(:product, price: nil)
        product.valid?
        expect(product.errors[:price]).to include("を入力してください")
      end

      it 'invalid postage_code' do
        product = FactoryBot.build(:product, postage_code: nil)
        product.valid?
        expect(product.errors[:postage_code]).to include("を入力してください")
      end

      it 'invalid explanation' do
        product = FactoryBot.build(:product, explanation: nil)
        product.valid?
        expect(product.errors[:explanation]).to include("を入力してください")
      end

      it 'invalid status' do
        product = FactoryBot.build(:product, status: nil)
        product.valid?
        expect(product.errors[:status]).to include("を入力してください")
      end

      it 'invalid prefecture_id' do
        product = FactoryBot.build(:product, prefecture_id: nil)
        product.valid?
        expect(product.errors[:prefecture_id]).to include("を入力してください")
      end

      it 'invalid delivery_time_code' do
        product = FactoryBot.build(:product, delivery_time_code: nil)
        product.valid?
        expect(product.errors[:delivery_time_code]).to include("を入力してください")
      end

      it 'invalid price' do
        product = FactoryBot.build(:product, price: nil)
        product.valid?
        expect(product.errors[:price]).to include("を入力してください")
      end

      it 'invalid price' do
        product = FactoryBot.build(:product, price: nil)
        product.valid?
        expect(product.errors[:price]).to include("を入力してください")
      end

      it 'invalid price' do
        product = FactoryBot.build(:product, price: nil)
        product.valid?
        expect(product.errors[:price]).to include("を入力してください")
      end

      it 'invalid price' do
        product = FactoryBot.build(:product, price: nil)
        product.valid?
        expect(product.errors[:price]).to include("を入力してください")
      end
    end
  end
end