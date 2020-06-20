class AddEmailsArrayToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :emailsArray, :string , array: true 
  end
end
