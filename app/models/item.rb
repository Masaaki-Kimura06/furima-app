class Item < ApplicationRecord
  has_many :images
  accepts_nested_attributes_for :images, allow_destroy: true

  validates_associated :images
  validates :images, presence: true

  validates :name, :detail, :condition, :price, :postage, :ship_from, :ship_date, presence: true

end
