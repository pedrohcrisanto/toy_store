class CreateSales < ActiveRecord::Migration[8.0]
  def change
    create_table :sales do |t|
      t.references :client, null: false, foreign_key: true
      t.decimal :value
      t.date :sale_date

      t.timestamps
    end
  end
end
