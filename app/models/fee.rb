class Fee < ActiveRecord::Base
  belongs_to :person
  # after_save :mescuota_todate

  MES      = ['1', '2', '3','4', '5', '6','7', '8', '9','10', '11', '12']
  def self.mescuota_options_for_select
    #GENDERS.to_enum.with_index(0).to_a
    MES.each.map { |t| [t, t.upcase.gsub(' ', '_')] }
  end 

  def head_daily
    daily = Daily.where(income_id: Income.where(id: self.income_id).first).first
    if daily.present?
      daily.numero
    else
      0
    end
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
        puts "**************"
        puts rowHash
        puts rowHash["ene-12"]
        puts "**************"

        # Enero
        if rowHash["ene-12"].present?
          fee_actual = @person.fees.where(mes_cuota: "01-2012").first
          if fee_actual.present?
            puts "****************"
            puts "EXISTE"
            puts @person.nro_registro
            puts "****************"
          else  
            puts "******* #{rowHash["fch_ene_12"]} *********"
            puts @person.nro_registro
            fee = Fee.new
            fee.fecha_pago = rowHash["fch_ene_12"].present? ? Date.parse(rowHash["fch_ene_12"]) : DateTime.now 
            fee.mes = "ENERO-2012"
            fee.mes_cuota = "01-2012"
            fee.monto = rowHash["ene-12"]
            fee.person_id = @person.id
            fee.rut = @person.rut
            fee.estado = "PAGADO"
            fee.nro_registro = @person.nro_registro
            fee.pagador = "ProcesoSistema"
            fee.save
          end  
        end  
        # Febrero
        if rowHash["feb-12"].present?
          fee_actual = @person.fees.where(mes_cuota: "02-2012").first
          if fee_actual.present?
            puts "****************"
            puts "EXISTE"
            puts @person.nro_registro
            puts "****************"
          else  
            puts "******* #{rowHash["fch_feb_12"]} *********"
            puts @person.nro_registro
            fee = Fee.new
            fee.fecha_pago = rowHash["fch_feb_12"].present? ? Date.parse(rowHash["fch_feb_12"]) : DateTime.now 
            fee.mes = "FEBRERO-2012"
            fee.mes_cuota = "02-2012"
            fee.monto = rowHash["feb-12"]
            fee.person_id = @person.id
            fee.rut = @person.rut
            fee.estado = "PAGADO"
            fee.nro_registro = @person.nro_registro
            fee.pagador = "ProcesoSistema"
            fee.save
          end  
        end  
        # Marzo
        if rowHash["mar-12"].present?
          fee_actual = @person.fees.where(mes_cuota: "03-2012").first
          if fee_actual.present?
            puts "****************"
            puts "EXISTE"
            puts @person.nro_registro
            puts "****************"
          else 
            puts "******* #{rowHash["fch_mar_12"]} *********"
            puts @person.nro_registro
            fee = Fee.new
            fee.fecha_pago = rowHash["fch_mar_12"].present? ? Date.parse(rowHash["fch_mar_12"]) : DateTime.now 
            fee.mes = "MARZO-2012"
            fee.mes_cuota = "03-2012"
            fee.monto = rowHash["mar-12"]
            fee.person_id = @person.id
            fee.rut = @person.rut
            fee.estado = "PAGADO"
            fee.nro_registro = @person.nro_registro
            fee.pagador = "ProcesoSistema"
            fee.save
          end  
        end  
        # Abril
        if rowHash["abr-12"].present?
          fee_actual = @person.fees.where(mes_cuota: "04-2012").first
          if fee_actual.present?
            puts "****************"
            puts "EXISTE"
            puts @person.nro_registro
            puts "****************"
          else 
            puts "******* #{rowHash["fch_abr_12"]} *********"
            puts @person.nro_registro
            fee = Fee.new
            fee.fecha_pago = rowHash["fch_abr_12"].present? ? Date.parse(rowHash["fch_abr_12"]) : DateTime.now 
            fee.mes = "ABRIL-2012"
            fee.mes_cuota = "04-2012"
            fee.monto = rowHash["abr-12"]
            fee.person_id = @person.id
            fee.rut = @person.rut
            fee.estado = "PAGADO"
            fee.nro_registro = @person.nro_registro
            fee.pagador = "ProcesoSistema"
            fee.save
          end  
        end  
        # MAYO
        if rowHash["may-12"].present?
          fee_actual = @person.fees.where(mes_cuota: "05-2012").first
          if fee_actual.present?
            puts "****************"
            puts "EXISTE"
            puts @person.nro_registro
            puts "****************"
          else 
            puts "******* #{rowHash["fch_may_12"]} *********"
            puts @person.nro_registro
            fee = Fee.new
            fee.fecha_pago = rowHash["fch_may_12"].present? ? Date.parse(rowHash["fch_may_12"]) : DateTime.now 
            fee.mes = "MAYO-2012"
            fee.mes_cuota = "05-2012"
            fee.monto = rowHash["may-12"]
            fee.person_id = @person.id
            fee.rut = @person.rut
            fee.estado = "PAGADO"
            fee.nro_registro = @person.nro_registro
            fee.pagador = "ProcesoSistema"
            fee.save
          end  
        end  
        # JUNIO
        if rowHash["jun-12"].present?
          fee_actual = @person.fees.where(mes_cuota: "06-2012").first
          if fee_actual.present?
            puts "****************"
            puts "EXISTE"
            puts @person.nro_registro
            puts "****************"
          else 
            puts "******* #{rowHash["fch_jun_12"]} *********"
            puts @person.nro_registro
            fee = Fee.new
            fee.fecha_pago = rowHash["fch_jun_12"].present? ? Date.parse(rowHash["fch_jun_12"]) : DateTime.now 
            fee.mes = "JUNIO-2012"
            fee.mes_cuota = "06-2012"
            fee.monto = rowHash["jun-12"]
            fee.person_id = @person.id
            fee.rut = @person.rut
            fee.estado = "PAGADO"
            fee.nro_registro = @person.nro_registro
            fee.pagador = "ProcesoSistema"
            fee.save
          end  
        end  
        # Julio
        if rowHash["jul-12"].present?
          fee_actual = @person.fees.where(mes_cuota: "07-2012").first
          if fee_actual.present?
            puts "****************"
            puts "EXISTE"
            puts @person.nro_registro
            puts "****************"
          else 
            puts "******* #{rowHash["fch_jul_12"]} *********"
            puts @person.nro_registro
            fee = Fee.new
            fee.fecha_pago = rowHash["fch_jul_12"].present? ? Date.parse(rowHash["fch_jul_12"]) : DateTime.now 
            fee.mes = "JULIO-2012"
            fee.mes_cuota = "07-2012"
            fee.monto = rowHash["jul-12"]
            fee.person_id = @person.id
            fee.rut = @person.rut
            fee.estado = "PAGADO"
            fee.nro_registro = @person.nro_registro
            fee.save
          end  
        end  
        # Agosto
        if rowHash["ago-12"].present?
          fee_actual = @person.fees.where(mes_cuota: "08-2012").first
          if fee_actual.present?
            puts "****************"
            puts "EXISTE"
            puts @person.nro_registro
            puts "****************"
          else 
            puts "******* #{rowHash["fch_ago_12"]} *********"
            puts @person.nro_registro
            fee = Fee.new
            fee.fecha_pago = rowHash["fch_ago_12"].present? ? Date.parse(rowHash["fch_ago_12"]) : DateTime.now 
            fee.mes = "AGOSTO-2012"
            fee.mes_cuota = "08-2012"
            fee.monto = rowHash["ago-12"]
            fee.person_id = @person.id
            fee.rut = @person.rut
            fee.estado = "PAGADO"
            fee.nro_registro = @person.nro_registro
            fee.pagador = "ProcesoSistema"
            fee.save
          end  
        end  
        # Septiembre
        if rowHash["sep-12"].present?
          fee_actual = @person.fees.where(mes_cuota: "09-2012").first
          if fee_actual.present?
            puts "****************"
            puts "EXISTE"
            puts @person.nro_registro
            puts "****************"
          else 
            puts "******* #{rowHash["fch_sep_12"]} *********"
            puts @person.nro_registro
            fee = Fee.new
            fee.fecha_pago = rowHash["fch_sep_12"].present? ? Date.parse(rowHash["fch_sep_12"]) : DateTime.now 
            fee.mes = "SEPTIEMBRE-2012"
            fee.mes_cuota = "09-2012"
            fee.monto = rowHash["sep-12"]
            fee.person_id = @person.id
            fee.rut = @person.rut
            fee.estado = "PAGADO"
            fee.nro_registro = @person.nro_registro
            fee.pagador = "ProcesoSistema"
            fee.save
          end  
        end  
        # Octubre
        if rowHash["oct-12"].present?
          fee_actual = @person.fees.where(mes_cuota: "10-2012").first
          if fee_actual.present?
            puts "****************"
            puts "EXISTE"
            puts @person.nro_registro
            puts "****************"
          else 
            puts "******* #{rowHash["fch_oct_12"]} *********"
            puts @person.nro_registro
            fee = Fee.new
            fee.fecha_pago = rowHash["fch_oct_12"].present? ? Date.parse(rowHash["fch_oct_12"]) : DateTime.now 
            fee.mes = "OCTUBRE-2012"
            fee.mes_cuota = "10-2012"
            fee.monto = rowHash["oct-12"]
            fee.person_id = @person.id
            fee.rut = @person.rut
            fee.estado = "PAGADO"
            fee.nro_registro = @person.nro_registro
            fee.pagador = "ProcesoSistema"
            fee.save
          end  
        end  
        # Noviembre
        if rowHash["nov-12"].present?
          fee_actual = @person.fees.where(mes_cuota: "11-2012").first
          if fee_actual.present?
            puts "****************"
            puts "EXISTE"
            puts @person.nro_registro
            puts "****************"
          else 
            puts "******* #{rowHash["fch_nov_12"]} *********"
            puts @person.nro_registro
            fee = Fee.new
            fee.fecha_pago = rowHash["fch_nov_12"].present? ? Date.parse(rowHash["fch_nov_12"]) : DateTime.now 
            fee.mes = "NOVIEMBRE-2012"
            fee.mes_cuota = "11-2012"
            fee.monto = rowHash["nov-12"]
            fee.person_id = @person.id
            fee.rut = @person.rut
            fee.estado = "PAGADO"
            fee.nro_registro = @person.nro_registro
            fee.pagador = "ProcesoSistema"
            fee.save
          end  
        end 
        # Diciembre
        if rowHash["dic-12"].present?
          fee_actual = @person.fees.where(mes_cuota: "12-2012").first
          if fee_actual.present?
            puts "****************"
            puts "EXISTE"
            puts @person.nro_registro
            puts "****************"
          else 
            puts "******* #{rowHash["fch_dic_12"]} *********"
            puts @person.nro_registro
            fee = Fee.new
            fee.fecha_pago = rowHash["fch_dic_12"].present? ? Date.parse(rowHash["fch_dic_12"]) : DateTime.now 
            fee.mes = "DICIEMBRE-2012"
            fee.mes_cuota = "12-2012"
            fee.monto = rowHash["dic-12"]
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
