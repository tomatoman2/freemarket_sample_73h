require 'rails_helper'
describe ProductImage do
  describe '#create' do
    context 'can save' do
      it 'imageがあれば保存できること' do
        expect(FactoryBot.build(:product_image)).to be_valid
      end
    end

    # 画像の必須確認はバリデーションではなくコントローラ側で行うため、ここでのテストは不要
    # context 'can not save' do
    #   it 'invalid name' do
    #     productimage = FactoryBot.build(:product_image, image_name: nil)
    #     productimage.valid?
    #     expect(productimage.errors[:image_name]).to include("を入力してください")
    #   end
    # end
  end
end