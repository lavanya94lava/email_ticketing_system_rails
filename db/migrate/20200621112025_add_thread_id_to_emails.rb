class AddThreadIdToEmails < ActiveRecord::Migration[6.0]
  def change
    add_column :emails, :thread_id, :string
  end
end
