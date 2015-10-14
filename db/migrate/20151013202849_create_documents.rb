class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :name
      t.string :file
      t.references :person, index: true

      t.timestamps
    end
  end
end
