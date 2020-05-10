require 'rails_helper'

describe Address do
  describe '#create' do
    # 1
    it "postal_code、prefecture_id,city,street,が存在すれば登録できること" do
      address = FactoryBot.build(:address)
      expect(address).to be_valid
    end

    # 2
    it "postal_codeがない場合は登録できないこと" do
      address = FactoryBot.build(:address, postal_code: nil)
      address.valid?
      expect(address.errors[:postal_code]).to include("を入力してください")
    end

    # 3
    it " prefecture_idがない場合は登録できないこと" do
      address = FactoryBot.build(:address, prefecture_id: nil)
      address.valid?
      expect(address.errors[:prefecture_id]).to include("を入力してください")
    end

    # 4
    it "cityがない場合は登録できないこと" do
      address = FactoryBot.build(:address, city: nil)
      address.valid?
      expect(address.errors[:city]).to include("を入力してください")
    end

    # 5
    it "streetがない場合は登録できないこと" do
      address = FactoryBot.build(:address, street: nil)
      address.valid?
      expect(address.errors[:street]).to include("を入力してください")
    end

  end
end