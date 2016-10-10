class CreateNationalCouncils < ActiveRecord::Migration
  def change
    create_table :national_councils do |t|
      t.string :nombre
      t.string :imagen
      t.string :cargo
      t.string :curriculum

      t.timestamps
    end
  end
end
