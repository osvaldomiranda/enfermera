class CreateDailies < ActiveRecord::Migration
  def change
    create_table :dailies do |t|
      t.integer :numero
      t.date :fecha
      t.references :cost_center, index: true
      t.references :account, index: true
      t.integer :debe
      t.integer :haber
      t.string :numdocumento
      t.string :detalle
      t.string :paguesea
      t.string :por
      t.string :tipo
      t.references :office, index: true
      t.references :income, index: true
      t.references :expense, index: true

      t.timestamps
    end
  end
end
