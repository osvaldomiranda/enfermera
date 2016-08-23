class CreateHeadDailies < ActiveRecord::Migration
  def change
    create_table :head_dailies do |t|
      t.integer :numero
      t.references :user, index: true

      t.timestamps
    end
  end
end
