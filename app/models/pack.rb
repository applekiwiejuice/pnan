class Pack < ApplicationRecord
  belongs_to :item
  validates :quantity, :price, presence: true
end
