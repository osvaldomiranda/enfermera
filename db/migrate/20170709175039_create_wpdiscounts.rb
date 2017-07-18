class CreateWpdiscounts < ActiveRecord::Migration
  def change
    create_table :wpdiscounts do |t|
      t.string :discountfile
      t.string :email
      t.references :workplace, index: true

      t.timestamps
    end
  end
end
