class CreateImageBuckets < ActiveRecord::Migration
  def change
    create_table :image_buckets do |t|
      t.string :image

      t.timestamps
    end
  end
end
