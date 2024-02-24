class Category < ApplicationRecord
    has_many :categorized_points, dependent: :destroy
    has_many :points, through: :categorized_points
end
