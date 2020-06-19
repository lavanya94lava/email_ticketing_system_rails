class CreateEmails < ActiveRecord::Migration[6.0]
  def change
    create_table :emails do |t|
      t.string :sender
      t.date :date
      t.text :body
      t.string :subject

      t.timestamps
    end
  end
end
