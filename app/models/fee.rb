class Fee < ActiveRecord::Base
  belongs_to :person
  # after_save :mescuota_todate

  MES      = ['1', '2', '3','4', '5', '6','7', '8', '9','10', '11', '12']
  def self.mescuota_options_for_select
    #GENDERS.to_enum.with_index(0).to_a
    MES.each.map { |t| [t, t.upcase.gsub(' ', '_')] }
  end 

  def mescuota_todate
    begin
      if self.mes_cuota.present?
        if self.mes_cuota.include? "-"
          m=self.mes_cuota[0..self.mes_cuota.index("-")-1]
          a=self.mes_cuota[self.mes_cuota.index("-")+1..100]
          self.update(mescuota: "1-#{m}-#{a})".to_date)
          "1-#{m}-#{a})".to_date
        else
          nil
        end  
      else
        nil
      end
    rescue
      nil
    end
  end


  def self.import_valpo(file)
    CSV.foreach(file.path, col_sep: ',', headers: true, encoding: "ISO-8859-1" ) do |row|
      rowHash = row.to_hash

      if rowHash["nro_registro"].present?
        @person = Person.where(nro_registro: rowHash["nro_registro"]).first 
      else   
        @person = Person.where(rut: rowHash["rut"]).first if rowHash["rut"].present?
      end

      if @person.present?
        puts "******* #{rowHash["fch_ene"]} *********"
        fee = Fee.new
        fee.fecha_pago = Date.parse(rowHash["fecha"]) 
        fee.mes = rowHash["mes"]
        fee.mes_cuota = rowHash["mes"]
        fee.monto = rowHash["monto"]
        fee.person_id = @person.id
        fee.rut = @person.rut
        fee.estado = "PAGADO"
        fee.nro_registro = @person.nro_registro
        fee.pagador = "ProcesoSistema"
        fee.save
      end    
    end
  end  

  def self.import(file)
    CSV.foreach(file.path, col_sep: ',', headers: true, encoding: "ISO-8859-1" ) do |row|
      rowHash = row.to_hash

      if rowHash["nro_registro"].present?
        @person = Person.where(nro_registro: rowHash["nro_registro"]).first 
      else   
        @person = Person.where(rut: rowHash["rut"]).first if rowHash["rut"].present?
      end

      if @person.present?

        # Enero
        if rowHash["ene-14"].present?
          fee_actual = @person.fees.where(mes_cuota: "01-2014").first
          if fee_actual.present?
            puts "****************"
            puts "EXISTE"
            puts @person.nro_registro
            puts "****************"
          else  
            puts "******* #{rowHash["fch_ene_14"]} *********"
            puts @person.nro_registro
            fee = Fee.new
            fee.fecha_pago = rowHash["fch_ene_14"].present? ? Date.parse(rowHash["fch_ene_14"]) : DateTime.now 
            fee.mes = "ENERO-2014"
            fee.mes_cuota = "01-2014"
            fee.monto = rowHash["ene-14"]
            fee.person_id = @person.id
            fee.rut = @person.rut
            fee.estado = "PAGADO"
            fee.nro_registro = @person.nro_registro
            fee.pagador = "ProcesoSistema"
            fee.save
          end  
        end  
        # Febrero
        if rowHash["feb-14"].present?
          fee_actual = @person.fees.where(mes_cuota: "02-2014").first
          if fee_actual.present?
            puts "****************"
            puts "EXISTE"
            puts @person.nro_registro
            puts "****************"
          else  
            puts "******* #{rowHash["fch_feb_14"]} *********"
            puts @person.nro_registro
            fee = Fee.new
            fee.fecha_pago = rowHash["fch_feb_14"].present? ? Date.parse(rowHash["fch_feb_14"]) : DateTime.now 
            fee.mes = "FEBRERO-2014"
            fee.mes_cuota = "02-2014"
            fee.monto = rowHash["feb-14"]
            fee.person_id = @person.id
            fee.rut = @person.rut
            fee.estado = "PAGADO"
            fee.nro_registro = @person.nro_registro
            fee.pagador = "ProcesoSistema"
            fee.save
          end  
        end  
        # Marzo
        if rowHash["mar-14"].present?
          fee_actual = @person.fees.where(mes_cuota: "03-2014").first
          if fee_actual.present?
            puts "****************"
            puts "EXISTE"
            puts @person.nro_registro
            puts "****************"
          else 
            puts "******* #{rowHash["fch_mar_14"]} *********"
            puts @person.nro_registro
            fee = Fee.new
            fee.fecha_pago = rowHash["fch_mar_14"].present? ? Date.parse(rowHash["fch_mar_14"]) : DateTime.now 
            fee.mes = "MARZO-2014"
            fee.mes_cuota = "03-2014"
            fee.monto = rowHash["mar-14"]
            fee.person_id = @person.id
            fee.rut = @person.rut
            fee.estado = "PAGADO"
            fee.nro_registro = @person.nro_registro
            fee.pagador = "ProcesoSistema"
            fee.save
          end  
        end  
        # Abril
        if rowHash["abr-14"].present?
          fee_actual = @person.fees.where(mes_cuota: "04-2014").first
          if fee_actual.present?
            puts "****************"
            puts "EXISTE"
            puts @person.nro_registro
            puts "****************"
          else 
            puts "******* #{rowHash["fch_abr_14"]} *********"
            puts @person.nro_registro
            fee = Fee.new
            fee.fecha_pago = rowHash["fch_abr_14"].present? ? Date.parse(rowHash["fch_abr_14"]) : DateTime.now 
            fee.mes = "ABRIL-2014"
            fee.mes_cuota = "04-2014"
            fee.monto = rowHash["abr-14"]
            fee.person_id = @person.id
            fee.rut = @person.rut
            fee.estado = "PAGADO"
            fee.nro_registro = @person.nro_registro
            fee.pagador = "ProcesoSistema"
            fee.save
          end  
        end  
        # MAYO
        if rowHash["may-14"].present?
          fee_actual = @person.fees.where(mes_cuota: "05-2014").first
          if fee_actual.present?
            puts "****************"
            puts "EXISTE"
            puts @person.nro_registro
            puts "****************"
          else 
            puts "******* #{rowHash["fch_may_14"]} *********"
            puts @person.nro_registro
            fee = Fee.new
            fee.fecha_pago = rowHash["fch_may_14"].present? ? Date.parse(rowHash["fch_may_14"]) : DateTime.now 
            fee.mes = "MAYO-2014"
            fee.mes_cuota = "05-2014"
            fee.monto = rowHash["may-14"]
            fee.person_id = @person.id
            fee.rut = @person.rut
            fee.estado = "PAGADO"
            fee.nro_registro = @person.nro_registro
            fee.pagador = "ProcesoSistema"
            fee.save
          end  
        end  
        # JUNIO
        if rowHash["jun-14"].present?
          fee_actual = @person.fees.where(mes_cuota: "06-2014").first
          if fee_actual.present?
            puts "****************"
            puts "EXISTE"
            puts @person.nro_registro
            puts "****************"
          else 
            puts "******* #{rowHash["fch_jun_14"]} *********"
            puts @person.nro_registro
            fee = Fee.new
            fee.fecha_pago = rowHash["fch_jun_14"].present? ? Date.parse(rowHash["fch_jun_14"]) : DateTime.now 
            fee.mes = "JUNIO-2014"
            fee.mes_cuota = "06-2014"
            fee.monto = rowHash["jun-14"]
            fee.person_id = @person.id
            fee.rut = @person.rut
            fee.estado = "PAGADO"
            fee.nro_registro = @person.nro_registro
            fee.pagador = "ProcesoSistema"
            fee.save
          end  
        end  
        # Julio
        if rowHash["jul-14"].present?
          fee_actual = @person.fees.where(mes_cuota: "07-2014").first
          if fee_actual.present?
            puts "****************"
            puts "EXISTE"
            puts @person.nro_registro
            puts "****************"
          else 
            puts "******* #{rowHash["fch_jul_14"]} *********"
            puts @person.nro_registro
            fee = Fee.new
            fee.fecha_pago = rowHash["fch_jul_14"].present? ? Date.parse(rowHash["fch_jul_14"]) : DateTime.now 
            fee.mes = "JULIO-2014"
            fee.mes_cuota = "07-2014"
            fee.monto = rowHash["jul-14"]
            fee.person_id = @person.id
            fee.rut = @person.rut
            fee.estado = "PAGADO"
            fee.nro_registro = @person.nro_registro
            fee.save
          end  
        end  
        # Agosto
        if rowHash["ago-14"].present?
          fee_actual = @person.fees.where(mes_cuota: "08-2014").first
          if fee_actual.present?
            puts "****************"
            puts "EXISTE"
            puts @person.nro_registro
            puts "****************"
          else 
            puts "******* #{rowHash["fch_ago_14"]} *********"
            puts @person.nro_registro
            fee = Fee.new
            fee.fecha_pago = rowHash["fch_ago_14"].present? ? Date.parse(rowHash["fch_ago_14"]) : DateTime.now 
            fee.mes = "AGOSTO-2014"
            fee.mes_cuota = "08-2014"
            fee.monto = rowHash["ago-14"]
            fee.person_id = @person.id
            fee.rut = @person.rut
            fee.estado = "PAGADO"
            fee.nro_registro = @person.nro_registro
            fee.pagador = "ProcesoSistema"
            fee.save
          end  
        end  
        # Septiembre
        if rowHash["sep-14"].present?
          fee_actual = @person.fees.where(mes_cuota: "09-2014").first
          if fee_actual.present?
            puts "****************"
            puts "EXISTE"
            puts @person.nro_registro
            puts "****************"
          else 
            puts "******* #{rowHash["fch_sep_14"]} *********"
            puts @person.nro_registro
            fee = Fee.new
            fee.fecha_pago = rowHash["fch_sep_14"].present? ? Date.parse(rowHash["fch_sep_14"]) : DateTime.now 
            fee.mes = "SEPTIEMBRE-2014"
            fee.mes_cuota = "09-2014"
            fee.monto = rowHash["sep-14"]
            fee.person_id = @person.id
            fee.rut = @person.rut
            fee.estado = "PAGADO"
            fee.nro_registro = @person.nro_registro
            fee.pagador = "ProcesoSistema"
            fee.save
          end  
        end  
        # Octubre
        if rowHash["oct-14"].present?
          fee_actual = @person.fees.where(mes_cuota: "10-2014").first
          if fee_actual.present?
            puts "****************"
            puts "EXISTE"
            puts @person.nro_registro
            puts "****************"
          else 
            puts "******* #{rowHash["fch_oct_14"]} *********"
            puts @person.nro_registro
            fee = Fee.new
            fee.fecha_pago = rowHash["fch_oct_14"].present? ? Date.parse(rowHash["fch_oct_14"]) : DateTime.now 
            fee.mes = "OCTUBRE-2014"
            fee.mes_cuota = "10-2014"
            fee.monto = rowHash["oct-14"]
            fee.person_id = @person.id
            fee.rut = @person.rut
            fee.estado = "PAGADO"
            fee.nro_registro = @person.nro_registro
            fee.pagador = "ProcesoSistema"
            fee.save
          end  
        end  
        # Noviembre
        if rowHash["nov-14"].present?
          fee_actual = @person.fees.where(mes_cuota: "11-2014").first
          if fee_actual.present?
            puts "****************"
            puts "EXISTE"
            puts @person.nro_registro
            puts "****************"
          else 
            puts "******* #{rowHash["fch_nov_14"]} *********"
            puts @person.nro_registro
            fee = Fee.new
            fee.fecha_pago = rowHash["fch_nov_14"].present? ? Date.parse(rowHash["fch_nov_14"]) : DateTime.now 
            fee.mes = "NOVIEMBRE-2014"
            fee.mes_cuota = "11-2014"
            fee.monto = rowHash["nov-14"]
            fee.person_id = @person.id
            fee.rut = @person.rut
            fee.estado = "PAGADO"
            fee.nro_registro = @person.nro_registro
            fee.pagador = "ProcesoSistema"
            fee.save
          end  
        end 
        # Diciembre
        if rowHash["dic-14"].present?
          fee_actual = @person.fees.where(mes_cuota: "12-2014").first
          if fee_actual.present?
            puts "****************"
            puts "EXISTE"
            puts @person.nro_registro
            puts "****************"
          else 
            puts "******* #{rowHash["fch_dic_14"]} *********"
            puts @person.nro_registro
            fee = Fee.new
            fee.fecha_pago = rowHash["fch_dic_14"].present? ? Date.parse(rowHash["fch_dic_14"]) : DateTime.now 
            fee.mes = "DICIEMBRE-2014"
            fee.mes_cuota = "12-2014"
            fee.monto = rowHash["dic-14"]
            fee.person_id = @person.id
            fee.rut = @person.rut
            fee.estado = "PAGADO"
            fee.nro_registro = @person.nro_registro
            fee.pagador = "ProcesoSistema"
            fee.save
          end  

# ***********************

        # Enero
        if rowHash["ene-15"].present?
          fee_actual = @person.fees.where(mes_cuota: "01-2015").first
          if fee_actual.present?
            puts "****************"
            puts "EXISTE"
            puts @person.nro_registro
            puts "****************"
          else  
            puts "******* #{rowHash["fch_ene_15"]} *********"
            puts @person.nro_registro
            fee = Fee.new
            fee.fecha_pago = rowHash["fch_ene_15"].present? ? Date.parse(rowHash["fch_ene_15"]) : DateTime.now 
            fee.mes = "ENERO-2015"
            fee.mes_cuota = "01-2015"
            fee.monto = rowHash["ene-15"]
            fee.person_id = @person.id
            fee.rut = @person.rut
            fee.estado = "PAGADO"
            fee.nro_registro = @person.nro_registro
            fee.pagador = "ProcesoSistema"
            fee.save
          end  
        end  
        # Febrero
        if rowHash["feb-15"].present?
          fee_actual = @person.fees.where(mes_cuota: "02-2015").first
          if fee_actual.present?
            puts "****************"
            puts "EXISTE"
            puts @person.nro_registro
            puts "****************"
          else  
            puts "******* #{rowHash["fch_feb_15"]} *********"
            puts @person.nro_registro
            fee = Fee.new
            fee.fecha_pago = rowHash["fch_feb_15"].present? ? Date.parse(rowHash["fch_feb_15"]) : DateTime.now 
            fee.mes = "FEBRERO-2015"
            fee.mes_cuota = "02-2015"
            fee.monto = rowHash["feb-15"]
            fee.person_id = @person.id
            fee.rut = @person.rut
            fee.estado = "PAGADO"
            fee.nro_registro = @person.nro_registro
            fee.pagador = "ProcesoSistema"
            fee.save
          end  
        end  
        # Marzo
        if rowHash["mar-15"].present?
          fee_actual = @person.fees.where(mes_cuota: "03-2015").first
          if fee_actual.present?
            puts "****************"
            puts "EXISTE"
            puts @person.nro_registro
            puts "****************"
          else 
            puts "******* #{rowHash["fch_mar_15"]} *********"
            puts @person.nro_registro
            fee = Fee.new
            fee.fecha_pago = rowHash["fch_feb_15"].present? ? Date.parse(rowHash["fch_feb_15"]) : DateTime.now 
            fee.mes = "MARZO-2015"
            fee.mes_cuota = "03-2015"
            fee.monto = rowHash["mar-15"]
            fee.person_id = @person.id
            fee.rut = @person.rut
            fee.estado = "PAGADO"
            fee.nro_registro = @person.nro_registro
            fee.pagador = "ProcesoSistema"
            fee.save
          end  
        end  
        # Abril
        if rowHash["abr-15"].present?
          fee_actual = @person.fees.where(mes_cuota: "04-2015").first
          if fee_actual.present?
            puts "****************"
            puts "EXISTE"
            puts @person.nro_registro
            puts "****************"
          else 
            puts "******* #{rowHash["fch_abr_15"]} *********"
            puts @person.nro_registro
            fee = Fee.new
            fee.fecha_pago = rowHash["fch_abr_15"].present? ? Date.parse(rowHash["fch_abr_15"]) : DateTime.now 
            fee.mes = "ABRIL-2015"
            fee.mes_cuota = "04-2015"
            fee.monto = rowHash["abr-15"]
            fee.person_id = @person.id
            fee.rut = @person.rut
            fee.estado = "PAGADO"
            fee.nro_registro = @person.nro_registro
            fee.pagador = "ProcesoSistema"
            fee.save
          end  
        end  
        # MAYO
        if rowHash["may-15"].present?
          fee_actual = @person.fees.where(mes_cuota: "05-2015").first
          if fee_actual.present?
            puts "****************"
            puts "EXISTE"
            puts @person.nro_registro
            puts "****************"
          else 
            puts "******* #{rowHash["fch_may_15"]} *********"
            puts @person.nro_registro
            fee = Fee.new
            fee.fecha_pago = rowHash["fch_may_15"].present? ? Date.parse(rowHash["fch_may_15"]) : DateTime.now 
            fee.mes = "MAYO-2015"
            fee.mes_cuota = "05-2015"
            fee.monto = rowHash["may-15"]
            fee.person_id = @person.id
            fee.rut = @person.rut
            fee.estado = "PAGADO"
            fee.nro_registro = @person.nro_registro
            fee.pagador = "ProcesoSistema"
            fee.save
          end  
        end  
        # JUNIO
        if rowHash["jun-15"].present?
          fee_actual = @person.fees.where(mes_cuota: "06-2015").first
          if fee_actual.present?
            puts "****************"
            puts "EXISTE"
            puts @person.nro_registro
            puts "****************"
          else 
            puts "******* #{rowHash["fch_jun_15"]} *********"
            puts @person.nro_registro
            fee = Fee.new
            fee.fecha_pago = rowHash["fch_jun_15"].present? ? Date.parse(rowHash["fch_jun_15"]) : DateTime.now 
            fee.mes = "JUNIO-2015"
            fee.mes_cuota = "06-2015"
            fee.monto = rowHash["jun-15"]
            fee.person_id = @person.id
            fee.rut = @person.rut
            fee.estado = "PAGADO"
            fee.nro_registro = @person.nro_registro
            fee.pagador = "ProcesoSistema"
            fee.save
          end  
        end  
        # Julio
        if rowHash["jul-15"].present?
          fee_actual = @person.fees.where(mes_cuota: "07-2015").first
          if fee_actual.present?
            puts "****************"
            puts "EXISTE"
            puts @person.nro_registro
            puts "****************"
          else 
            puts "******* #{rowHash["fch_jul_15"]} *********"
            puts @person.nro_registro
            fee = Fee.new
            fee.fecha_pago = rowHash["fch_jul_15"].present? ? Date.parse(rowHash["fch_jul_15"]) : DateTime.now 
            fee.mes = "JULIO-2015"
            fee.mes_cuota = "07-2015"
            fee.monto = rowHash["jul-15"]
            fee.person_id = @person.id
            fee.rut = @person.rut
            fee.estado = "PAGADO"
            fee.nro_registro = @person.nro_registro
            fee.save
          end  
        end  
        # Agosto
        if rowHash["ago-15"].present?
          fee_actual = @person.fees.where(mes_cuota: "08-2015").first
          if fee_actual.present?
            puts "****************"
            puts "EXISTE"
            puts @person.nro_registro
            puts "****************"
          else 
            puts "******* #{rowHash["fch_ago_15"]} *********"
            puts @person.nro_registro
            fee = Fee.new
            fee.fecha_pago = rowHash["fch_ago_15"].present? ? Date.parse(rowHash["fch_ago_15"]) : DateTime.now 
            fee.mes = "AGOSTO-2015"
            fee.mes_cuota = "08-2015"
            fee.monto = rowHash["ago-15"]
            fee.person_id = @person.id
            fee.rut = @person.rut
            fee.estado = "PAGADO"
            fee.nro_registro = @person.nro_registro
            fee.pagador = "ProcesoSistema"
            fee.save
          end  
        end  
        # Septiembre
        if rowHash["sep-15"].present?
          fee_actual = @person.fees.where(mes_cuota: "09-2015").first
          if fee_actual.present?
            puts "****************"
            puts "EXISTE"
            puts @person.nro_registro
            puts "****************"
          else 
            puts "******* #{rowHash["fch_sep_15"]} *********"
            puts @person.nro_registro
            fee = Fee.new
            fee.fecha_pago = rowHash["fch_sep_15"].present? ? Date.parse(rowHash["fch_sep_15"]) : DateTime.now 
            fee.mes = "SEPTIEMBRE-2015"
            fee.mes_cuota = "09-2015"
            fee.monto = rowHash["sep-15"]
            fee.person_id = @person.id
            fee.rut = @person.rut
            fee.estado = "PAGADO"
            fee.nro_registro = @person.nro_registro
            fee.pagador = "ProcesoSistema"
            fee.save
          end  
        end  
        # Octubre
        if rowHash["oct-15"].present?
          fee_actual = @person.fees.where(mes_cuota: "10-2015").first
          if fee_actual.present?
            puts "****************"
            puts "EXISTE"
            puts @person.nro_registro
            puts "****************"
          else 
            puts "******* #{rowHash["fch_oct_15"]} *********"
            puts @person.nro_registro
            fee = Fee.new
            fee.fecha_pago = rowHash["fch_oct_15"].present? ? Date.parse(rowHash["fch_oct_15"]) : DateTime.now 
            fee.mes = "OCTUBRE-2015"
            fee.mes_cuota = "10-2015"
            fee.monto = rowHash["oct-15"]
            fee.person_id = @person.id
            fee.rut = @person.rut
            fee.estado = "PAGADO"
            fee.nro_registro = @person.nro_registro
            fee.pagador = "ProcesoSistema"
            fee.save
          end  
        end  
        # Noviembre
        if rowHash["nov-15"].present?
          fee_actual = @person.fees.where(mes_cuota: "11-2015").first
          if fee_actual.present?
            puts "****************"
            puts "EXISTE"
            puts @person.nro_registro
            puts "****************"
          else 
            puts "******* #{rowHash["fch_nov_15"]} *********"
            puts @person.nro_registro
            fee = Fee.new
            fee.fecha_pago = rowHash["fch_nov_15"].present? ? Date.parse(rowHash["fch_nov_15"]) : DateTime.now 
            fee.mes = "NOVIEMBRE-2015"
            fee.mes_cuota = "11-2015"
            fee.monto = rowHash["nov-15"]
            fee.person_id = @person.id
            fee.rut = @person.rut
            fee.estado = "PAGADO"
            fee.nro_registro = @person.nro_registro
            fee.pagador = "ProcesoSistema"
            fee.save
          end  
        end 
        # Diciembre
        if rowHash["dic-15"].present?
          fee_actual = @person.fees.where(mes_cuota: "12-2015").first
          if fee_actual.present?
            puts "****************"
            puts "EXISTE"
            puts @person.nro_registro
            puts "****************"
          else 
            puts "******* #{rowHash["fch_dic_15"]} *********"
            puts @person.nro_registro
            fee = Fee.new
            fee.fecha_pago = rowHash["fch_dic_15"].present? ? Date.parse(rowHash["fch_dic_15"]) : DateTime.now 
            fee.mes = "DICIEMBRE-2015"
            fee.mes_cuota = "12-2015"
            fee.monto = rowHash["dic-15"]
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
end
end
