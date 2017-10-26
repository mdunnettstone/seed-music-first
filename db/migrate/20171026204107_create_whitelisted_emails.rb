class CreateWhitelistedEmails < ActiveRecord::Migration[5.0]
  def change
    create_table :whitelisted_emails do |t|
      t.string :email_or_domain
      t.timestamps
    end
  end
end
