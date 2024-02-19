# frozen_string_literal: true

module Types
  class PointType < Types::BaseObject
    field :id, ID, null: false
    field :name, String
    field :description, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    field :point_count, Integer, null: true

    def point_count 
      Point.all.size
    end

  end
end
