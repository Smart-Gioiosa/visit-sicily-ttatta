class Mutations::CreatePoint < Mutations::BaseMutation
    argument :name, String, required: true
    argument :description, String, required: true

    field :point, Types::PointType, null: false
    field :errors, [String], null: false

    def resolve(name:, description:)
        point = Point.new(name: name, description: description)

        if point.save
            {point: point, errors: []}
        else
            {point: nil, errors: point.errors.full_messages}
        end
    end

end
