class AddCertifFileToPerson < ActiveRecord::Migration
  def change
    add_column :people, :certificado_file, :string
  end
end
