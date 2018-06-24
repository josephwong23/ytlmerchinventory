class MemberDivision < ApplicationRecord
  validates :name, uniqueness: { case_sensitive: false }

  has_paper_trail
end
