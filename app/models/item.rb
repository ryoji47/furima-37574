class Item < ApplicationRecord
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
    validates :days_id
    validates :price
  end
end
