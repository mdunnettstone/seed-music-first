class CreateUserInstruments < ActiveRecord::Migration[5.0]
  def change
    create_table :user_instruments do |t|
      t.references :user
      t.references :instrument
      t.references :genre
      t.timestamps
    end
  end
end
