class CreateRols < ActiveRecord::Migration
  def change
    create_table :rols do |t|
      t.string :nombre
      t.references :user, index: true
      t.string :region

      t.timestamps
    end
  end
end
