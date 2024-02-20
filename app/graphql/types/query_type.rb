# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject


    #Get a specific category
    field :category, CategoryType, null: false do
      argument :id, ID, required: true
    end

    field :category_name, CategoryType, null: false do
      argument :name, String, required: true
    end


    def category(id:)
      Category.find(id)
    end

    def category_name(name:)
      Category.find_by!(name: name)
    end



    field :points, [Types::PointType], null: false #Restituisce un array di points
    def points
      Point.all
    end

    #Get a specific point 
    field :point, Types::PointType, null: false do
      argument :id, ID, required: true
    end

    def point(id:)
      Point.find(id)
    end


    field :node, Types::NodeType, null: true, description: "Fetches an object given its ID." do
      argument :id, ID, required: true, description: "ID of the object."
    end

    def node(id:)
      context.schema.object_from_id(id, context)
    end

    field :nodes, [Types::NodeType, null: true], null: true, description: "Fetches a list of objects given a list of IDs." do
      argument :ids, [ID], required: true, description: "IDs of the objects."
    end

    def nodes(ids:)
      ids.map { |id| context.schema.object_from_id(id, context) }
    end

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # TODO: remove me
    field :test_field, String, null: false,
      description: "An example field added by the generator"
    def test_field
      "Hello World!"
    end
  end
end
