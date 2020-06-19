class AddMailIdToEmails < ActiveRecord::Migration[6.0]
  def change
    add_column :emails, :mail_id, :string, unique: true
  end
end
