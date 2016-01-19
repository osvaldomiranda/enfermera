class CreateFees < ActiveRecord::Migration
  def change
    create_table :fees do |t|
      t.string :rut
      t.string :email
      t.date :fecha_pago
      t.string :mes
      t.float :monto
      t.references :person, index: true

      t.timestamps
    end
  end
end
