class RemoveColumnCertToInscription < ActiveRecord::Migration
  def change
    remove_column :inscriptions, :url, :string
    remove_column :inscriptions, :certificado_html, :string
  end
end
