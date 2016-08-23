class CreateCandidates < ActiveRecord::Migration
  def change
    create_table :candidates do |t|
      t.string :candidato
      t.references :position, index: true
      t.references :vote, index: true

      t.timestamps
    end
  end
end
