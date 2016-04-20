class CreateDetailIncomes < ActiveRecord::Migration
  def change
    create_table :detail_incomes do |t|
      t.string :pcontable
      t.string :fcontable
      t.string :tipo_comprobante
      t.string :mescuota
      t.string :detalle
      t.float :debe
      t.float :haber
      t.string :obeservacion
      t.references :account, index: true
      t.references :workplace, index: true
      t.references :cost_center, index: true
      t.references :income, index: true

      t.timestamps
    end
  end
end
