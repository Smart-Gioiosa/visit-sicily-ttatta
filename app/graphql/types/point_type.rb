# frozen_string_literal: true
include(Rails.application.routes.url_helpers)
module Types
  class PointType < Types::BaseObject
    field :id, ID, null: false
    field :name, String
    field :description, String
    field :city, String
    field :address, String
    field :country, String
    field :zipcode, String
    field :latitude, Float
    field :longitude, Float
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    field :cover_image_url, String, null: true

    field :point_count, Integer, null: true

    def point_count 
      Point.all.size
    end

    def cover_image_url
      if object.cover_image.present?
        rails_blob_path(object.cover_image, only_path: true)
      end
    end

  end
end
