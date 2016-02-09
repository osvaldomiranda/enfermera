class CreateOfficeaccounts < ActiveRecord::Migration
  def change
    create_table :officeaccounts do |t|
      t.date :fecha
      t.string :tipo
      t.float :monto
      t.string :codigo
      t.string :account
      t.references :user, index: true
      t.references :office, index: true
      t.references :income, index: true
      t.references :expense, index: true

      t.timestamps
    end
  end
end
