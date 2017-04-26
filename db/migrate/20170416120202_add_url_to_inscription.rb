class AddUrlToInscription < ActiveRecord::Migration
  def change
    add_column :inscriptions, :url, :string
    add_column :inscriptions, :certificado_html, :text
  end
end
