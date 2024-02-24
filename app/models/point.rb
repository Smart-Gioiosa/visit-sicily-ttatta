class Point < ApplicationRecord
    has_many :categorized_points, dependent: :destroy
    has_many :categories, through: :categorized_points
    has_one_attached :cover_image

    def acceptable_image
        return unless image.attached?
        
        unless cover_image.blob.byte_size <= 1.megabyte
            errors.add(:cover_image, "is too big")
        end

        acceptable_types = ["image/jpeg", "image/png", "image/webp"]

        unless acceptable_types.include?(cover_image.content_type)
            errors.add(:cover_image, "must be a JPEG, PNG or WEBP")
        end
    end

end
