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
        expect(@buy_order.errors.full_messages).to include("Token can't be blank")
      end
      it 'userが紐付いていないと購入できない' do
        @buy_order.user_id = nil
        @buy_order.valid?
        expect(@buy_order.errors.full_messages).to include("User can't be blank")
      end
      it 'itemが紐付いていないと購入できない' do
        @buy_order.item_id = nil
        @buy_order.valid?
        expect(@buy_order.errors.full_messages).to include("Item can't be blank")
      end
      it 'post_codeが空では購入できない' do
        @buy_order.post_code = ''
        @buy_order.valid?
        expect(@buy_order.errors.full_messages).to include("Post code can't be blank")
      end
      it 'postal_codeが「3桁ハイフン4桁」の半角文字列でないと購入できない' do
        @buy_order.post_code = '1234567'
        @buy_order.valid?
        expect(@buy_order.errors.full_messages).to include('Post code is invalid. Include hyphen(-)')
      end
      it 'prefecture_idが---では購入できない' do
        @buy_order.prefecture_id = 0
        @buy_order.valid?
        expect(@buy_order.errors.full_messages).to include('Prefecture 選択して下さい')
      end
      it 'cityが空では購入できない' do
        @buy_order.city = nil
        @buy_order.valid?
        expect(@buy_order.errors.full_messages).to include("City can't be blank")
      end
      it 'addressが空では購入できない' do
        @buy_order.address = nil
        @buy_order.valid?
        expect(@buy_order.errors.full_messages).to include("Address can't be blank")
      end
      it 'phone_numberが空では購入できない' do
        @buy_order.phone_number = nil
        @buy_order.valid?
        expect(@buy_order.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberが10桁以上11桁以内の半角数値でないと購入できない' do
        @buy_order.phone_number = '514432'
        @buy_order.valid?
        expect(@buy_order.errors.full_messages).to include('Phone number is invalid')
      end
    end
  end
end
