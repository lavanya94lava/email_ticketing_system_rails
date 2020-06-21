class AddIsResolvedToEmails < ActiveRecord::Migration[6.0]
  def change
    add_column :emails, :isResolved, :boolean, default: false
  end
end
