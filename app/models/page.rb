class Page < ApplicationRecord
  belongs_to :sheet
  validates_uniqueness_of :row, scope: [:column, :sheet_id]
end
