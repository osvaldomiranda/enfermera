class AddColumnUrlToPerson < ActiveRecord::Migration
  def change
    add_column :people, :url, :text
    add_column :people, :certificado_html, :text
  end
end
