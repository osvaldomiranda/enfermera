class CreateIncomes < ActiveRecord::Migration
  def change
    create_table :incomes do |t|
      t.datetime :fecha
      t.float :monto
      t.string :tipo
      t.string :document
      t.string :banco
      t.string :mediopago
      t.references :person, index: true
      t.references :workplace, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
