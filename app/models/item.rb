class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :sales_status
  belongs_to_active_hash :postage
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :scheduled_delivery

  belongs_to :user
  has_one :buy
  has_one_attached :image

  with_options presence: true do
    validates :name
    validates :explanation
    validates :category_id
    validates :sales_status_id
    validates :postage_id
    validates :prefecture_id
    validates :scheduled_delivery_id
    validates :price
  end

  with_options numericality: { other_than: 1, message: 'を選択して下さい' } do
    validates :category_id
    validates :sales_status_id
    validates :postage_id
    validates :scheduled_delivery_id
  end

  validates :image, presence: { message: 'を添付してください' }

  validates :prefecture_id, numericality: { other_than: 0, message: 'を選択して下さい' }

  validates :price, numericality: { only_integer: true, message: 'は半角数値で入力して下さい' }
  validates :price,
            numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999,
                            message: 'は¥300~¥9,999,999の間で入力して下さい' }
end
