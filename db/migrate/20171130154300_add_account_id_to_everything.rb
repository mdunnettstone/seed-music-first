class AddAccountIdToEverything < ActiveRecord::Migration[5.0]
  def change
    tables = [:bookings, :posts, :post_replies, :rooms, :room_comments, :room_facilities, :users, :user_bookings, :user_instruments, :whitelisted_emails]

    tables.each do |table_name|
      add_column table_name, :account_id, :integer
    end
  end
end
