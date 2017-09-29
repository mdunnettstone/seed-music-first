class CreateFacilities < ActiveRecord::Migration[5.0]
  def change
    create_table :facilities do |t|
      t.string :instrument
      t.string :brand
      t.string :model
      t.timestamps
    end
  end
end
