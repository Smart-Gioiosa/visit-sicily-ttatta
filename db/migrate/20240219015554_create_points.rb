class CreatePoints < ActiveRecord::Migration[7.1]
  def change
    create_table :points do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
