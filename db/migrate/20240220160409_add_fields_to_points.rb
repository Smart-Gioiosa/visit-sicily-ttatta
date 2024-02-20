class AddFieldsToPoints < ActiveRecord::Migration[7.1]
  def change
    add_column :points, :city, :string
    add_column :points, :address, :string
    add_column :points, :country, :string
    add_column :points, :zipcode, :string
    add_column :points, :latitude, :float
    add_column :points, :longitude, :float
  end
end
