class CreateCategorizedPoints < ActiveRecord::Migration[7.1]
  def change
    create_table :categorized_points do |t|
      t.references :category, null: false, foreign_key: true
      t.references :point, null: false, foreign_key: true

      t.timestamps
    end
  end
end
