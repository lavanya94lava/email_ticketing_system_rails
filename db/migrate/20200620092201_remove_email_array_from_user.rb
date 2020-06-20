class RemoveEmailArrayFromUser < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :emailArray, :array
  end
end
