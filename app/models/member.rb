class Member < ApplicationRecord
  belongs_to :member_division
  has_many :orders
  has_many :items, through: :orders

  validates :name, presence: true
  validates :email, presence: true
  validates :phone, presence: true

  has_paper_trail
end
