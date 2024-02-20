module Mutations
    module Points
        class Add < Mutations::BaseMutation
            argument :name, String, required: true
            argument :description, String, required: true
            argument :city, String
            argument :address, String
            argument :zipcode, String
            argument :country, String
            argument :latitude, Float
            argument :longitude, Float

            graphql_name "AddPoint"

            field :point, Types::PointType, null: false
            field :errors, [String], null: false

            def resolve(name:, description:, city:, address:, zipcode:, country:, latitude:, longitude:)
                point = Point.new(name: name, 
                                description: description, 
                                city: city, 
                                address: address, 
                                zipcode: zipcode, 
                                country: country,
                                latitude: latitude,
                                longitude: longitude)

                if point.save
                    {point: point, errors: []}
                else
                    {point: nil, errors: point.errors.full_messages}
                end
            end

        end
    end
end