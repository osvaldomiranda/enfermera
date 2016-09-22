class Fee < ActiveRecord::Base
  belongs_to :person

  MES      = ['1', '2', '3','4', '5', '6','7', '8', '9','10', '11', '12']
  def self.mescuota_options_for_select
    #GENDERS.to_enum.with_index(0).to_a
    MES.each.map { |t| [t, t.upcase.gsub(' ', '_')] }
  end 



  def self.import(file)
    CSV.foreach(file.path, col_sep: ';', headers: true, encoding: "ISO-8859-1" ) do |row|
      rowHash = row.to_hash

      if rowHash["nro_registro"].present?
        @person = Person.where(nro_registro: rowHash["nro_registro"]).first 
      else   
        @person = Person.where(rut: rowHash["rut"]).first if rowHash["rut"].present?
      end

      if @person.present?

        # Enero
        if rowHash["ene"].present?
          fee = Fee.new
          fee.fecha_pago = Date.parse(rowHash["fch_ene"])
          fee.mes = "ENERO-2016"
          fee.mes_cuota = "01-2016"
          fee.monto = rowHash["ene"]
          fee.person_id = @person.id
          fee.rut = @person.rut
          fee.estado = "PAGADO"
          fee.nro_registro = @person.nro_registro
          fee.pagador = "ProcesoSistema"
          fee.save
        end  
        # Febrero
        if rowHash["feb"].present?
          fee = Fee.new
          fee.fecha_pago = Date.parse(rowHash["fch_feb"])
          fee.mes = "FEBRERO-2016"
          fee.mes_cuota = "02-2016"
          fee.monto = rowHash["feb"]
          fee.person_id = @person.id
          fee.rut = @person.rut
          fee.estado = "PAGADO"
          fee.nro_registro = @person.nro_registro
          fee.pagador = "ProcesoSistema"
          fee.save
        end  
        # Marzo
        if rowHash["mar"].present?
          fee = Fee.new
          fee.fecha_pago = Date.parse(rowHash["fch_mar"])
          fee.mes = "MARZO-2016"
          fee.mes_cuota = "03-2016"
          fee.monto = rowHash["mar"]
          fee.person_id = @person.id
          fee.rut = @person.rut
          fee.estado = "PAGADO"
          fee.nro_registro = @person.nro_registro
          fee.pagador = "ProcesoSistema"
          fee.save
        end  
        # Abril
        if rowHash["abr"].present?
          fee = Fee.new
          fee.fecha_pago = Date.parse(rowHash["fch_abr"])
          fee.mes = "ABRIL-2016"
          fee.mes_cuota = "04-2016"
          fee.monto = rowHash["abr"]
          fee.person_id = @person.id
          fee.rut = @person.rut
          fee.estado = "PAGADO"
          fee.nro_registro = @person.nro_registro
          fee.pagador = "ProcesoSistema"
          fee.save
        end  
        # MAYO
        if rowHash["may"].present?
          fee = Fee.new
          fee.fecha_pago = Date.parse(rowHash["fch_may"])
          fee.mes = "MAYO-2016"
          fee.mes_cuota = "05-2016"
          fee.monto = rowHash["may"]
          fee.person_id = @person.id
          fee.rut = @person.rut
          fee.estado = "PAGADO"
          fee.nro_registro = @person.nro_registro
          fee.pagador = "ProcesoSistema"
          fee.save
        end  
        # JUNIO
        if rowHash["jun"].present?
          fee = Fee.new
          fee.fecha_pago = Date.parse(rowHash["fch_jun"])
          fee.mes = "JUNIO-2016"
          fee.mes_cuota = "06-2016"
          fee.monto = rowHash["jun"]
          fee.person_id = @person.id
          fee.rut = @person.rut
          fee.estado = "PAGADO"
          fee.nro_registro = @person.nro_registro
          fee.pagador = "ProcesoSistema"
          fee.save
        end  
        # Julio
        if rowHash["jul"].present?
          fee = Fee.new
          fee.fecha_pago = Date.parse(rowHash["fch_jul"])
          fee.mes = "JULIO-2016"
          fee.mes_cuota = "07-2016"
          fee.monto = rowHash["jul"]
          fee.person_id = @person.id
          fee.rut = @person.rut
          fee.estado = "PAGADO"
          fee.nro_registro = @person.nro_registro
          fee.save
        end  
        # Agosto
        if rowHash["ago"].present?
          fee = Fee.new
          fee.fecha_pago = Date.parse(rowHash["fch_ago"])
          fee.mes = "AGOSTO-2016"
          fee.mes_cuota = "08-2016"
          fee.monto = rowHash["ago"]
          fee.person_id = @person.id
          fee.rut = @person.rut
          fee.estado = "PAGADO"
          fee.nro_registro = @person.nro_registro
          fee.pagador = "ProcesoSistema"
          fee.save
        end  
        # Septiembre
        if rowHash["sep"].present?
          fee = Fee.new
          fee.fecha_pago = Date.parse(rowHash["fch_sep"])
          fee.mes = "SEPTIEMBRE-2016"
          fee.mes_cuota = "09-2016"
          fee.monto = rowHash["sep"]
          fee.person_id = @person.id
          fee.rut = @person.rut
          fee.estado = "PAGADO"
          fee.nro_registro = @person.nro_registro
          fee.pagador = "ProcesoSistema"
          fee.save
        end  
        # Octubre
        if rowHash["oct"].present?
          fee = Fee.new
          fee.fecha_pago = Date.parse(rowHash["fch_oct"])
          fee.mes = "OCTUBRE-2016"
          fee.mes_cuota = "10-2016"
          fee.monto = rowHash["oct"]
          fee.person_id = @person.id
          fee.rut = @person.rut
          fee.estado = "PAGADO"
          fee.nro_registro = @person.nro_registro
          fee.pagador = "ProcesoSistema"
          fee.save
        end  
        # Noviembre
        if rowHash["nov"].present?
          fee = Fee.new
          fee.fecha_pago = Date.parse(rowHash["fch_nov"])
          fee.mes = "NOVIEMBRE-2016"
          fee.mes_cuota = "11-2016"
          fee.monto = rowHash["nov"]
          fee.person_id = @person.id
          fee.rut = @person.rut
          fee.estado = "PAGADO"
          fee.nro_registro = @person.nro_registro
          fee.pagador = "ProcesoSistema"
          fee.save
        end 
        # Diciembre
        if rowHash["dic"].present?
          fee = Fee.new
          fee.fecha_pago = Date.parse(rowHash["fch_dic"])
          fee.mes = "DICIEMBRE-2016"
          fee.mes_cuota = "12-2016"
          fee.monto = rowHash["dic"]
          fee.person_id = @person.id
          fee.rut = @person.rut
          fee.estado = "PAGADO"
          fee.nro_registro = @person.nro_registro
          fee.pagador = "ProcesoSistema"
          fee.save
        end  
      end   
    end    
  end  

end
