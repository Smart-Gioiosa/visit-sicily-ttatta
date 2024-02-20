class Point < ApplicationRecord
    has_many :categorized_points
    has_many :categories, through: :categorized_points
end
