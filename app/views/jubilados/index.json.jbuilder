json.array!(@jubilados) do |jubilado|
  json.extract! jubilado, :id, :ultimo_empleador, :institucion_pagadora, :afp, :cia_seguro, :person_id
  json.url jubilado_url(jubilado, format: :json)
end
