class Item < ApplicationRecord
  belongs_to :category, required: true
  belongs_to :member_division

  has_many :orders, dependent: :destroy
  has_many :members, through: :orders

  validates :name, presence: true

  has_paper_trail
end
