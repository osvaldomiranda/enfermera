class CreateBenefits < ActiveRecord::Migration
  def change
    create_table :benefits do |t|
      t.string :institucion
      t.string :resumen
      t.string :imagen
      t.text :web
      t.references :office, index: true

      t.timestamps
    end
  end
end
