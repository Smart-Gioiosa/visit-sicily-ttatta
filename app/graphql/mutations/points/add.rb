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
            argument :cover_image, ApolloUploadServer::Upload, required: true

            graphql_name "AddPoint"

            field :point, Types::PointType, null: false
            field :errors, [String], null: false

            #def resolve(name:, description:, city:, address:, zipcode:, country:, latitude:, longitude:, cover_image:)
            def resolve(input)

                file = input[:cover_image]
                blob = ActiveStorage::Blob.create_and_upload!(
                    io: file,
                    filename: file.original_filename,
                    content_type: file.content_type
                )


                point = Point.new(
                                name: input[:name],
                                description: input[:description],
                                city: input[:city],
                                address: input[:address],
                                zipcode: input[:zipcode],
                                country: input[:country],
                                latitude: input[:latitude],
                                longitude: input[:longitude], 
                                cover_image: blob
                                )

                if point.save
                    {point: point, errors: []}
                else
                    {point: nil, errors: point.errors.full_messages}
                end
            end

        end
    end
end



#correct!
#{"query": "mutation ($name: String!, $description: String!, $city: String!, $address: String!, $zipcode: String!, $country: String!, $latitude: Float!, $longitude: Float!, $coverImage: Upload!) { addPoint( input: {name: $name description: $description city: $city address: $address zipcode: $zipcode country: $country latitude: $latitude longitude: $longitude coverImage: $coverImage}) { point { id name description city address zipcode country  latitude longitude coverImageUrl} errors } }", "variables": { "name": "Canapè di Gioiosa Marea", "description": "Canapè di Gioiosa Marea", "city": "Gioiosa Marea", "address": "Via Umberto I", "zipcode": "98063", "country": "Italia",  "latitude": 38.3456, "longitude": 14.235646, "coverImage": null }}
#{"0":["variables.cover_image"]}
#{"query": "mutation ($name: String!, $description: String!, $city: String!, $address: String!, $zipcode: String!, $country: String!, $latitude: Float!, $longitude: Float!, $coverImage: Upload!) { addPoint( input: {name: $name description: $description city: $city address: $address zipcode: $zipcode country: $country latitude: $latitude longitude: $longitude coverImage: $coverImage}) { point { id name description city address zipcode country  latitude longitude coverImageUrl} errors } }", "variables": { "name": "Canapè di Gioiosa Marea", "description": "Canapè di Gioiosa Marea", "city": "Gioiosa Marea", "address": "Via Umberto I", "zipcode": "98063", "country": "Italia",  "latitude": 38.3456, "longitude": 14.235646, "coverImage": null }}
