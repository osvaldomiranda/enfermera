class CreateDetailExpenses < ActiveRecord::Migration
  def change
    create_table :detail_expenses do |t|
      t.string :numcomprobante
      t.float :debe
      t.float :haber
      t.string :paguesea
      t.string :por
      t.string :observacion
      t.references :account, index: true
      t.references :cost_center, index: true
      t.references :expense, index: true

      t.timestamps
    end
  end
end
