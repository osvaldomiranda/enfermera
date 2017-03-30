class AddMesCuotaToFee < ActiveRecord::Migration
  def change
    add_column :fees, :mescuota, :datetime
  end
end
