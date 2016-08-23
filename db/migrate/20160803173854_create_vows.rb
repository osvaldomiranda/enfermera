class CreateVows < ActiveRecord::Migration
  def change
    create_table :vows do |t|
      t.string :token
      t.references :candidate, index: true
      t.references :position, index: true
      t.references :vote, index: true
      t.references :workplace, index: true

      t.timestamps
    end
  end
end
