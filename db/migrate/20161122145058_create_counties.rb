class CreateCounties < ActiveRecord::Migration
  def change
    create_table :counties do |t|
      t.string :name
      t.references :state, index: true, null: false, foreign_key: true

      t.timestamps null: false
    end
    add_index :counties, :name, unique: true
  end
end
