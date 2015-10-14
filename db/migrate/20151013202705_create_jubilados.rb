class CreateJubilados < ActiveRecord::Migration
  def change
    create_table :jubilados do |t|
      t.string :ultimo_empleador
      t.string :institucion_pagadora
      t.string :afp
      t.string :cia_seguro
      t.references :person, index: true

      t.timestamps
    end
  end
end
