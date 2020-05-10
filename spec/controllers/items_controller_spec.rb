require 'rails_helper'

describe ItemsController do
  #テスト環境のカテゴリーテーブルを事前に準備すること！！
  describe 'GET #new' do
    it "new.html.erbに遷移すること" do
      get :new
      expect(response).to render_template :new
    end
  end
  describe 'GET #edit' do
    it "@productに正しい値が入っていること" do
      product = FactoryBot.create(:product)
      get :edit, params: { id: product }
      binding.pry
      expect(assigns(:item)).to eq product
    end
    it "edit.html.hamlに遷移すること" do
      product = FactoryBot.create(:product)
      get :edit, params: { id: product }
      expect(response).to render_template :edit
    end
  end
end