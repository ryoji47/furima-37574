require 'rails_helper'

RSpec.describe BuyOrder, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @buy_order = FactoryBot.build(:buy_order, user_id: user.id, item_id: item.id)
    sleep 0.1
  end

  describe '商品購入機能' do
    context '購入できる時' do
      it '必要な情報を適切に入力すると購入できる' do
        expect(@buy_order).to be_valid
      end
      it 'building_nameは空でも購入できる' do
        @buy_order.building_name = ''
        expect(@buy_order).to be_valid
      end
    end
    context '購入できない時' do
      it 'tokenが空では購入できない' do
        @buy_order.token = nil
        @buy_order.valid?
        expect(@buy_order.errors.full_messages).to include("クレジットカード情報を入力してください")
      end
      it 'userが紐付いていないと購入できない' do
        @buy_order.user_id = nil
        @buy_order.valid?
        expect(@buy_order.errors.full_messages).to include("Userを入力してください")
      end
      it 'itemが紐付いていないと購入できない' do
        @buy_order.item_id = nil
        @buy_order.valid?
        expect(@buy_order.errors.full_messages).to include("Itemを入力してください")
      end
      it 'post_codeが空では購入できない' do
        @buy_order.post_code = ''
        @buy_order.valid?
        expect(@buy_order.errors.full_messages).to include("郵便番号を入力してください")
      end
      it 'postal_codeが「3桁ハイフン4桁」の半角文字列でないと購入できない' do
        @buy_order.post_code = '1234567'
        @buy_order.valid?
        expect(@buy_order.errors.full_messages).to include('郵便番号は3桁ハイフン4桁半角で入力してください')
      end
      it 'prefecture_idが---では購入できない' do
        @buy_order.prefecture_id = 0
        @buy_order.valid?
        expect(@buy_order.errors.full_messages).to include('都道府県を選択して下さい')
      end
      it 'cityが空では購入できない' do
        @buy_order.city = nil
        @buy_order.valid?
        expect(@buy_order.errors.full_messages).to include("市区町村を入力してください")
      end
      it 'addressが空では購入できない' do
        @buy_order.address = nil
        @buy_order.valid?
        expect(@buy_order.errors.full_messages).to include("番地を入力してください")
      end
      it 'phone_numberが空では購入できない' do
        @buy_order.phone_number = nil
        @buy_order.valid?
        expect(@buy_order.errors.full_messages).to include("電話番号を入力してください")
      end
      it 'phone_numberが12桁以上では購入できない' do
        @buy_order.phone_number = '090123412345'
        @buy_order.valid?
        expect(@buy_order.errors.full_messages).to include('電話番号は10桁以上11桁以内の半角数値で入力してください')
      end
      it 'phone_numberが9桁以下では購入できない' do
        @buy_order.phone_number = '519989'
        @buy_order.valid?
        expect(@buy_order.errors.full_messages).to include('電話番号は10桁以上11桁以内の半角数値で入力してください')
      end
      it 'phone_numberにに半角数字以外が含まれている場合は購入できない' do
        @buy_order.phone_number = '090-8787-9898'
        @buy_order.valid?
        expect(@buy_order.errors.full_messages).to include('電話番号は10桁以上11桁以内の半角数値で入力してください')
      end
    end
  end
end
