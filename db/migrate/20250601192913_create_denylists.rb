class CreateDenylists < ActiveRecord::Migration[8.0]
  def change
    create_table :denylists do |t|
      t.string :jti, null: false
      t.datetime :exp, null: false # Tempo de expiração do token revogado

      t.timestamps
    end
    add_index :denylists, :jti, unique: true # Garanta que o índice seja único
  end
end
