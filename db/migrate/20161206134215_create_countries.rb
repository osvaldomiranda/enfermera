class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :nombre

      t.timestamps
    end
  end
end
