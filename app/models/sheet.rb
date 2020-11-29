class Sheet < ApplicationRecord
  belongs_to :work
  validates_uniqueness_of :title
  validates_uniqueness_of :number, scope: [:work_id]
end
