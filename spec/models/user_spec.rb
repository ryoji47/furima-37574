require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる時' do
      it '全ての情報が正しく入力されれば登録できる' do
        expect(@user).to be_valid
      end
    end
    context '新規登録できない時' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'emailは@を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = '12345'
        @user.password_confirmation = '12345'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
    end
  end

  describe '本人情報確認' do
    it '名字が空では登録できない' do
      @user.family_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name can't be blank")
    end
    it '名前が空では登録できない' do
      @user.first_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end
    it '名字が英語だと入力できない' do
      @user.family_name = 'Belmonte'
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name is invalid")
    end
    it '名前が英語だと入力できない' do
      @user.first_name = 'Jason'
      @user.valid?
      expect(@user.errors.full_messages).to include("First name is invalid")
    end
    it '名字のカナが空では登録できない' do
      @user.family_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name kana can't be blank")
    end
    it '名前のカナが空では登録できない' do
      @user.first_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana can't be blank")
    end
    it '名字のカナはひらがなは使用できない' do
      @user.family_name_kana = 'やまだ'
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name kana is invalid")
    end
    it '名字のカナは漢字は使用できない' do
      @user.family_name_kana = '山田'
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name kana is invalid")
    end
    it '名字のカナは英語は使用できない' do
      @user.family_name_kana = 'Yamada'
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name kana is invalid")
    end
    it '名前のカナはひらがなは使用できない' do
      @user.first_name_kana = 'りょうじ'
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana is invalid")
    end
    it '名前のカナは漢字は使用できない' do
      @user.first_name_kana = '凌司'
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana is invalid")
    end
    it '名前のカナは英語は使用できない' do
      @user.first_name_kana = 'Ryoji'
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana is invalid")
    end
    it '生年月日が空では登録できない' do
      @user.birth_day = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Birth day can't be blank")
    end
  end
end

