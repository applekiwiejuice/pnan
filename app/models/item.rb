class Item < ApplicationRecord
    has_many :packs, dependent: :destroy
    validates :item_name, :item_code, presence: true
end
