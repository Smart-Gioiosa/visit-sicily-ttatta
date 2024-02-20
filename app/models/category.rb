class Category < ApplicationRecord
    has_many :categorized_points
    has_many :points, through: :categorized_points
end
