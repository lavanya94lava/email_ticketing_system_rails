class AddReferencesToEmails < ActiveRecord::Migration[6.0]
  def change
    add_reference :emails, :user, foreign_key: true
  end
end
