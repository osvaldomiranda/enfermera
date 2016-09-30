class AddWorkplaceToHeadDaily < ActiveRecord::Migration
  def change
    add_reference :head_dailies, :office, index: true
    add_reference :head_dailies, :workplace, index: true
  end
end
