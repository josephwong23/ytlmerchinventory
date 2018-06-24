class Category < ApplicationRecord
  has_many :items

  validates :name, uniqueness: { case_sensitive: false }

  has_paper_trail
end
