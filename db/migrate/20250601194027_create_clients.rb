class CreateClients < ActiveRecord::Migration[8.0]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :email
      t.date :date_of_birth

      t.timestamps
    end
  end
end
