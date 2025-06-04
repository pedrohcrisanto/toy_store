class AddIndexToSalesValue < ActiveRecord::Migration[8.0]
  def change
    add_index :sales, :value
  end
end
