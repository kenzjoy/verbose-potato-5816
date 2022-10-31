class Supermarket < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :location

  has_many :items
end