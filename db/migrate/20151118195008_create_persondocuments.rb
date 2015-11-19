class CreatePersondocuments < ActiveRecord::Migration
  def change
    create_table :persondocuments do |t|
      t.string :nombre
      t.string :tipo
      t.string :documento
      t.references :person, index: true

      t.timestamps
    end
  end
end
