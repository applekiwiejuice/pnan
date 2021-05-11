class Item < ApplicationRecord
    has_many :packs
    validates :item_name, :item_code, presence: true
end
