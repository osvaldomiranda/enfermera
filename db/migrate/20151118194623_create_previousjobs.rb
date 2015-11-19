class CreatePreviousjobs < ActiveRecord::Migration
  def change
    create_table :previousjobs do |t|
      t.string :establecimiento
      t.string :ciudad
      t.string :region
      t.date :desde
      t.date :hasta
      t.references :person, index: true

      t.timestamps
    end
  end
end
