class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.datetime :fecha
      t.float :monto
      t.string :tipo
      t.string :document
      t.string :descripcion
      t.string :mediopago
      t.references :office, index: true
      t.references :user_id, index: true
      t.string :estado

      t.timestamps
    end
  end
end
