class Work < ApplicationRecord
  validates_uniqueness_of :title
end
