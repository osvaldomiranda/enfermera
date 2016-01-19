class CreateOffices < ActiveRecord::Migration
  def change
    create_table :offices do |t|
      t.string :nombre
      t.string :region
      t.string :ciudad
      t.string :email
      t.string :contacto

      t.timestamps
    end
  end
end
