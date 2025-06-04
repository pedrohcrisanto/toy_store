class AddIndexesToSales < ActiveRecord::Migration[8.0]
  def change
    add_index :sales, :sale_date
  end
end
