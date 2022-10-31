class Item < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :price

  belongs_to :supermarket
  has_many :customer_items
  has_many :customers, through: :customer_items
end