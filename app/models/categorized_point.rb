class CategorizedPoint < ApplicationRecord
  belongs_to :category
  belongs_to :point
end
