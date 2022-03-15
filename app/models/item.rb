class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :sales_status
  belongs_to_active_hash :postage
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :scheduled_delivery

  belongs_to :user
  has_one_attached :image

  with_options presence: true do
    validates :name
    validates :image
    validates :explanation
    validates :category_id
    validates :sales_status_id
    validates :postage_id
    validates :prefecture_id
    validates :scheduled_delivery_id
    validates :price
  end

  with_options numericality: { other_than: 1, message: "Please choose"} do
    validates :category_id
    validates :sales_status_id
    validates :postage_id
    validates :prefecture_id
    validates :scheduled_delivery_id
  end
end
