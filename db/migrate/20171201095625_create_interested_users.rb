class CreateInterestedUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :interested_users do |t|
      t.string :email
      t.string :postcode
      t.string :company
      t.timestamps
    end
  end
end
