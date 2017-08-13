class CreateWpemails < ActiveRecord::Migration
  def change
    create_table :wpemails do |t|
      t.string :email
      t.references :workplace, index: true

      t.timestamps
    end
  end
end
