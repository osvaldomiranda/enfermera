class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :codigo
      t.string :nombre

      t.timestamps
    end
  end
end
