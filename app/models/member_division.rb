class MemberDivision < ApplicationRecord
  validates :name, uniqueness: { case_sensitive: false }
end
