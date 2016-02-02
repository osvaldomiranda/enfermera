class CreateCurrentfees < ActiveRecord::Migration
  def change
    create_table :currentfees do |t|
      t.float :valor

      t.timestamps
    end
  end
end
