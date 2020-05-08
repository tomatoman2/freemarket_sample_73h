require 'rails_helper'

describe User do
  describe '#create' do
    context 'can save' do

      # 1
      it "nicknameとemail、passwordとpassword_confirmation、family_name、first_name、kana_family_name、kana_first_name、birthdayが存在すれば登録できること" do
        user = FactoryBot.build(:user)
        expect(user).to be_valid
      end
    end
    context 'can not save' do

      # 2
      it " nicknameがない場合は登録できないこと" do
        user = FactoryBot.build(:user, nickname: nil)
        user.valid?
        puts(expect(user.errors[:nickname]).to include("を入力してください"))
        expect(user.errors[:nickname]).to include("を入力してください")
      end

      # 3
      it "emailがない場合は登録できないこと" do
        user = FactoryBot.build(:user, email: nil)
        user.valid?
        expect(user.errors[:email]).to include("を入力してください")
      end

      # 4
      it "passwordがない場合は登録できないこと" do
        user = FactoryBot.build(:user, password: nil)
        user.valid?
        expect(user.errors[:password]).to include("を入力してください")
      end

      # 5
      it "passwordが存在してもpassword_confirmationがない場合は登録できないこと" do
        user = FactoryBot.build(:user, password_confirmation: "")
        user.valid?
        expect(user.errors[:password_confirmation]).to include("とPasswordの入力が一致しません")
      end

      # 6
      it " 重複したemailが存在する場合は登録できないこと " do
        user = FactoryBot.create(:user)
        another_user = FactoryBot.build(:user, email: user.email)
        another_user.valid?
        puts(another_user.errors.full_messages)
        expect(another_user.errors[:email]).to include("はすでに存在します")
      end

      # 7
      it " passwordが7文字以上であれば登録できること " do
        user = FactoryBot.build(:user, password: "0000000", password_confirmation: "0000000")
        user.valid?
        expect(user).to be_valid
      end

      # 8
      it " passwordが6文字以下であれば登録できないこと " do
        user = FactoryBot.build(:user, password: "000000", password_confirmation: "000000")
        user.valid?
        expect(user.errors[:password]).to include("は7文字以上で入力してください")
      end

      # 9
      it "family_nameがない場合は登録できないこと" do
        user = FactoryBot.build(:user, family_name: nil)
        user.valid?
        expect(user.errors[:family_name]).to include("を入力してください")
      end

      # 10
      it "first_nameがない場合は登録できないこと" do
        user = FactoryBot.build(:user, first_name: nil)
        user.valid?
        expect(user.errors[:first_name]).to include("を入力してください")
      end  

      # 11
      it "kana_family_nameがない場合は登録できないこと" do
        user = FactoryBot.build(:user, kana_family_name: nil)
        user.valid?
        expect(user.errors[:kana_family_name]).to include("を入力してください")
      end
      
      # 12
      it "kana_first_nameがない場合は登録できないこと" do
        user = FactoryBot.build(:user, kana_first_name: nil)
        user.valid?
        expect(user.errors[:kana_first_name]).to include("を入力してください")
      end    

      # 13
      it "birthdayがない場合は登録できないこと" do
        user = FactoryBot.build(:user, birthday: nil)
        user.valid?
        expect(user.errors[:birthday]).to include("を入力してください")
      end
    end
  end
end