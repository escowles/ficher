class Page < ApplicationRecord
  belongs_to :sheet
  validates_uniqueness_of :row, scope: [:col, :sheet_id]
end
