class AddColumnCertToInscription < ActiveRecord::Migration
  def change
    add_column :inscriptions, :url, :text
    add_column :inscriptions, :certificado_html, :text
  end
end
