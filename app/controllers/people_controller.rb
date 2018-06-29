class PeopleController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_person, only: [:show, :edit, :cancel, :update, :destroy, :picture, :terms, :termstopdf, :payregister, :certificado, :incomplete_fee]

  respond_to :html

  def index

    if params["/people"].present?
      @apellido_paterno = params["/people"][:apellido_paterno]
      @apellido_materno = params["/people"][:apellido_materno]
      @rut = params["/people"][:rut] || nil
      @nro_registro = params["/people"][:nro_registro] || nil
    end  
 
    @estado = params[:estado] || nil
    @lugar_trabajo = params[:lugar_trabajo] || nil


    if params[:office].present?
      office_id = Office.where(nombre:params[:office]).first.id 
    else  
      office_id = nil
    end  
    @office = params[:office] || nil
    @member = true

    if (current_user.rol <= 7)
      office_id = current_user.office.id
    end
    @people = Person.office(office_id).member(@member).active(@estado).workplace(@lugar_trabajo).with_paterno(@apellido_paterno).with_materno(@apellido_materno).with_rut(@rut).with_registro(@nro_registro).order(created_at: :desc).page(params[:page]).per_page(20)  
    respond_with(@people)
  end

  def resetpass

    person = Person.find(params[:id])

    user = User.where(rut: person.rut).first

    if user.present?
      user.password = user.rut
      user.save
    end

    redirect_to people_path    
  end


  def continuity
    if params["/people"].present?
      @apellido_paterno = params["/people"][:apellido_paterno]
      @apellido_materno = params["/people"][:apellido_materno]
      @rut = params["/people"][:rut] || nil
      @nro_registro = params["/people"][:nro_registro] || nil
    end  
 
    @estado = params[:estado] || nil
    @lugar_trabajo = params[:lugar_trabajo] || nil


    if params[:office].present?
      office_id = Office.where(nombre:params[:office]).first.id 
    else  
      office_id = nil
    end  
    @office = params[:office] || nil
    @member = true

    if (current_user.rol <= 7)
      office_id = current_user.office.id
    end
    @people = Person.office(office_id).member(@member).active(@estado).workplace(@lugar_trabajo).with_paterno(@apellido_paterno).with_materno(@apellido_materno).with_rut(@rut).with_registro(@nro_registro).order(created_at: :desc).page(params[:page]).per_page(20)  
    respond_with(@people)
  end

  def continuity2
    if params["/people"].present?
      @apellido_paterno = params["/people"][:apellido_paterno]
      @apellido_materno = params["/people"][:apellido_materno]
      @rut = params["/people"][:rut] || nil
      @nro_registro = params["/people"][:nro_registro] || nil
    end  
 
    @estado = params[:estado] || nil
    @lugar_trabajo = params[:lugar_trabajo] || nil


    if params[:office].present?
      office_id = Office.where(nombre:params[:office]).first.id 
    else  
      office_id = nil
    end  
    @office = params[:office] || nil
    @member = true

    if (current_user.rol <= 7)
      office_id = current_user.office.id
    end
    @people = Person.candidate(true).office(office_id).member(@member).active(@estado).workplace(@lugar_trabajo).with_paterno(@apellido_paterno).with_materno(@apellido_materno).with_rut(@rut).with_registro(@nro_registro).order(created_at: :desc).page(params[:page]).per_page(20)  
    respond_with(@people)
  end


  def continuity_toxls

    if params["/people"].present?
      @apellido_paterno = params["/people"][:apellido_paterno]
      @apellido_materno = params["/people"][:apellido_materno]
      @rut = params["/people"][:rut] || nil
      @nro_registro = params["/people"][:nro_registro] || nil
    end  
 
    @estado = params[:estado] || nil
    @lugar_trabajo = params[:lugar_trabajo] || nil


    if params[:office].present?
      office_id = Office.where(nombre:params[:office]).first.id 
    else  
      office_id = nil
    end  
    @office = params[:office] || nil
    @member = true

    if (current_user.rol <= 7)
      office_id = current_user.office.id
    end

    @people = Person.office(office_id).member(@member).active(@estado).workplace(@lugar_trabajo).with_paterno(@apellido_paterno).with_materno(@apellido_materno).with_rut(@rut).with_registro(@nro_registro).order(created_at: :desc) 
    respond_to do |format|
      format.xls 
    end
  end

  def toxls
    if params["/people"].present?
      @apellido_paterno = params["/people"][:apellido_paterno]
      @apellido_materno = params["/people"][:apellido_materno]
      @rut = params["/people"][:rut] || nil
      @nro_registro = params["/people"][:nro_registro] || nil
    end  
 
    @estado = params[:estado] || nil
    @lugar_trabajo = params[:lugar_trabajo] || nil


    if params[:office].present?
      office_id = Office.where(nombre:params[:office]).first.id 
    else  
      office_id = nil
    end  
    @office = params[:office] || nil
    @member = true

    if (current_user.rol <= 7)
      office_id = current_user.office.id
    end

    @people = Person.office(office_id).member(@member).active(@estado).workplace(@lugar_trabajo).with_paterno(@apellido_paterno).with_materno(@apellido_materno).with_rut(@rut).with_registro(@nro_registro).order(created_at: :desc) 
    respond_to do |format|
      format.xls 
    end
  end

  def show
    @head_dailies = HeadDaily.where(rut: @person.rut) 
    respond_with(@person) 
  end

  def new
    @person = Person.new
    respond_modal_with(@person)
  end


  def picture
    respond_modal_with(@person)
  end

  def certificado
    respond_modal_with(@person)
  end


  def edit
    @valorcuota = Currentfee.last.valor
    respond_with(@person)
  end

  def create
    @person = Person.new(person_params)
    @person.save

    respond_with(@person)
  end

  def cancel
    @person = Person.find(params[:id])
    @person.estado = "CANCELADO"
    if @person.save
      user = User.find_by_rut( @person.rut)
      if user.present?
        user.password = 'cancelado'
        user.save
      end
    end  
    redirect_to people_path
  end

  
  def update

    @persondocuments = Persondocument.all

    if person_params[:certificado_file].present?
      pp = person_params
      pp[:estado] = "OK"
      @person.update(pp)
      redirect_to people_path
    else  

      if !person_params[:picture].present?
        if !person_params[:rut].present?
          if person_params[:terms].present?
            @person.terms = "OK"
            @person.fechaterms = DateTime.now
            @person.save
            if current_user.rut == @person.rut
              redirect_to dashboard_index_path
            else
              redirect_to person_path(@person.id)
            end
          else   
            render "error"
          end 
        else        
          if @person.update(person_params)
            if current_user.rut == @person.rut
              redirect_to dashboard_index_path
            else
              redirect_to person_path(@person.id)
            end
          else
            if person_params[:terms].present?
              @person.terms = "OK"
              @person.fechaterms = DateTime.now
              @person.save
              if current_user.rut == @person.rut
                redirect_to dashboard_index_path
              else  
                redirect_to person_path(@person.id)
              end
            else  
              respond_with(@person)
            end  
          end
        end  
      else
        @person.update(person_params)
        if current_user.rut == @person.rut
          redirect_to dashboard_index_path
        else
          redirect_to person_path(@person.id)
        end
      end  
    end
  end

  def destroy
    @person.destroy
    respond_with(@person)
  end

  def terms
    @person = Person.find(params[:id])
    respond_modal_with(@person)
  end

  def termstopdf
    @person = Person.find(params[:id])
    puts "****************"
    puts @person
    puts params[:id]
    puts "****************"

    render pdf: "terms", formats: :html, encoding: 'utf8'   # Excluding ".pdf" extension.
  end


  def import

    puts "*****************"
    puts params
    puts "*****************"
    @people = Person.all
    @msg = Person.import(params[:file]).force_encoding('utf-8')
    respond_to do |format|
      format.html {
        if @msg == " "
          render action: 'index', notice: "Colegiadas Ok"
        else
          render '/people/error'
        end  
      }
    end   
  end

  def import_wpemail
    puts "*****************"
    puts params
    puts "*****************"
    @people = Person.all
    @msg = Person.import_update_fechainscripcion(params[:file]).force_encoding('utf-8')
    respond_to do |format|
      format.html {
        if @msg == " "
          render action: 'index', notice: "WP Ok"
        else
          render '/people/error'
        end  
      }
    end   
  end

  def import_wpemailss
    puts "*****************"
    puts params
    puts "*****************"
    @people = Person.all
    @msg = Workplace.import_emailss(params[:file]).force_encoding('utf-8')
    respond_to do |format|
      format.html {
        if @msg == " "
          render action: 'index', notice: "WP Ok"
        else
          render '/people/error'
        end  
      }
    end   
  end

  def import_update
    puts "*****************"
    puts params
    puts "*****************"
    @people = Person.all
    @msg = Person.import_update(params[:file]).force_encoding('utf-8')
    respond_to do |format|
      format.html {
        if @msg == " "
          render action: 'index', notice: "Colegiadas Ok"
        else
          render '/people/error'
        end  
      }
    end   
  end

    def import_update_email
    puts "*****************"
    puts params
    puts "*****************"
    @people = Person.all
    @msg = Person.import_update_email(params[:file]).force_encoding('utf-8')
    respond_to do |format|
      format.html {
        if @msg == " "
          render action: 'index', notice: "Colegiadas Ok"
        else
          render '/people/error'
        end  
      }
    end   
  end

  def create_user
    puts "*****************"
    puts params
    puts "*****************"
    @people = Person.all
    @msg = Person.create_user(params[:file]).force_encoding('utf-8')
    respond_to do |format|
      format.html {
        if @msg == " "
          render action: 'index', notice: "Colegiadas Ok"
        else
          render '/people/error'
        end  
      }
    end   
  end

  def create_fee
    puts "*****************"
    puts params
    puts "*****************"
    @people = Person.all
    @msg = Fee.import(params[:file]).force_encoding('utf-8')
    respond_to do |format|
      format.html {
        if @msg == " "
          render action: 'index', notice: "Colegiadas Ok"
        else
          render '/people/error'
        end  
      }
    end   
  end  

  def create_head_daily
    @people = Person.all
    @msg = HeadDaily.import(params[:file]).force_encoding('utf-8')
    respond_to do |format|
      format.html {
        if @msg == " "
          render action: 'index', notice: "Colegiadas Ok"
        else
          render '/people/error'
        end  
      }
    end   
  end  


  def create_head_daily_egreso
    @people = Person.all
    @msg = HeadDaily.import_egreso(params[:file]).force_encoding('utf-8')
    respond_to do |format|
      format.html {
        if @msg == " "
          render action: 'index', notice: "Colegiadas Ok"
        else
          render '/people/error'
        end  
      }
    end   
  end  

  def create_daily
    @people = Person.all
    @msg = Daily.import(params[:file]).force_encoding('utf-8')
    respond_to do |format|
      format.html {
        if @msg == " "
          render action: 'index', notice: "Colegiadas Ok"
        else
          render '/people/error'
        end  
      }
    end   
  end  


  def payregister
    @m
    nto = 0
    fees_array = []
    current_year = Time.now.year
    past_year = current_year - 1

    if @person.isretired?
      current_value = 1500
      past_value = 1500
    else  
      current_value = Currentfee.where(year: current_year).present? ? Currentfee.where(year: current_year).first.valor : 0
      past_value = Currentfee.where(year: past_year).present? ? Currentfee.where(year: past_year).first.valor : 0
    end  

    inscription =  @person.fecha_inscripcion.present? ? @person.fecha_inscripcion : Time.now

    if inscription.year <= past_year
      month_past_year = inscription.year == past_year ? inscription.month : 0
      1.upto(12) do |i|
        if i > month_past_year
          if @person.fees.where(mes_cuota:"#{i}-#{past_year}").present?
            fees_array << [mes: "#{i}-#{past_year}", monto: past_value, estado: 'Pagado']
          else  
            fees_array << [mes: "#{i}-#{past_year}", monto: past_value, estado: 'Impago']
            @monto = @monto + past_value
          end
        end    
      end
    end  

    month_current_year = inscription.year == current_year ? inscription.month : 0
    1.upto(12) do |i|
      if i >= month_current_year
        if @person.fees.where(mes_cuota:"#{i}-#{current_year}").present?
          fees_array << [mes: "#{i}-#{current_year}", monto: current_value, estado: 'Pagado']
        else  
          fees_array << [mes: "#{i}-#{current_year}", monto: current_value, estado: 'Impago']
          @monto = @monto + current_value
        end
      end    
    end

    @fees = Hash[fees_array]

    @income = Income.new
  end

  def pay
    @fees = eval(params[:income][:fees])
    @person = Person.find(params[:income][:person_id])
    n = params[:person_ids].present? ? params[:person_ids].count : 0
    msg = ""

    msg+= n <= 0 ? "No se han elegido cuotas a cancelar  "  : ""
    msg+= params[:income][:monto].to_i <= 0 ? "El monto a pagar no puede ser cero  "  : ""

    if current_user.role?("regional_admin") 
      msg+= params[:income][:document].present? ? "" : "Por favor, adjunte comprobante de pago o deposito  " 
    end  

    #validar que no haya lagunas
    if params[:person_ids].present?
      next_month = params[:person_ids][0][0..1].gsub('-','').to_i + 1
      (1..n-1).each do |i|
        mes  = params[:person_ids][i][0..1].gsub('-','').to_i
        if mes != next_month
          msg += "El pago de las cuotas debe ser continuo, no puede haber lagunas impagas"
          break
        end 
        next_month += 1
        if next_month >= 13
          next_month = 1
        end  
      end
    end

    #verifica que se pague el mas antiguo pendiente
    if msg == ""
      @fees.each do |fee|
        if Hash[fee[0]][:estado] == "Impago"
          if params[:person_ids][0] !=  Hash[fee[0]][:mes]
            msg += "El pago de las cuotas debe ser continuo, no puede haber 'lagunas' impagas"            
          end
          break  
        end 
      end  
    end  

    if msg != ""
      redirect_to error_pay_person_path(msg: msg)  
    else 

      if params[:income][:fecha_pago] == '' || params[:income][:fecha_contable] ==''
        fecha_pago = DateTime.now.strftime("%d-%m-%Y")
        fecha_contable = DateTime.now.strftime("%d-%m-%Y")
      else  
        fecha_pago     = params[:income][:fecha_pago]
        fecha_contable = params[:income][:fecha_contable]
      end
      workplace = Workplace.where(id:params[:income][:workplace_id]).first

      @income = Income.new
      @income.monto       =  params[:income][:monto]
      @income.person_id   =  params[:income][:person_id]
      @income.workplace_id=  params[:income][:workplace_id]
      @income.office_id   =  workplace.office_id
      @income.tipo        = "Colegiada"
      @income.user_id     =  params[:income][:user_id]
      @income.document    =  params[:income][:document]
      @income.banco       =  params[:income][:banco]
      @income.mediopago   =  params[:income][:mediopago]
      @income.fecha_pago  =  Date.parse(fecha_pago)
      @income.fecha_contable  = Date.parse( fecha_contable)
      @income.mes_cuota   = ""
      @income.fecha       =  DateTime.now
      @income.estado      = "CONFIRMADO"

      if @income.save

        params[:person_ids].each do |mes_cuota|
          mes  = mes_cuota[0..1].gsub('-','').to_i
          year = mes_cuota[2..6].gsub('-','').to_i  

          valorcuota = Currentfee.where(year: year).present? ? Currentfee.where(year: year).first.valor : nil

          if @person.isretired?
            valorcuota = 1500
          end  

          fee = Fee.new
          fee.rut = @person.rut
          fee.email = @person.email
          fee.fecha_pago = Date.parse(fecha_pago)
          fee.mes = mes
          fee.monto = valorcuota
          fee.mes_cuota = mes_cuota
          fee.person_id = @person.id

          if current_user.role?(:finance)
            fee.pagador = "Pago Registrado Admin"
            fee.estado = "Confirmado"
          else
            fee.pagador = "Pago Directo Colegiada"
            fee.estado = "Por Confirmar"
          end
          
          fee.income_id = @income.id
          fee.mescuota = Date.parse("01-#{mes_cuota}")
          fee.save
        end
      end
      
      @persondocuments = Persondocument.all

      if current_user.rut ==   @income.person.rut
        redirect_to dashboard_index_path
      else
        redirect_to person_path(params[:income][:person_id])
      end
    end
  end


  def incomplete_fee
    @income = Income.new
  end

  def incomplete_pay

    @person = Person.find(params[:income][:person_id])
    msg = ""

    msg+= @person.present? ? ""  : "No se encontró colegiada  "
    msg+= params[:income][:monto].to_i <= 0 ? "El monto a pagar no puede ser cero  "  : ""

 
    if msg != ""
      redirect_to error_pay_person_path(msg: msg)  
    else 

      if params[:income][:fecha_pago] == '' || params[:income][:fecha_contable] ==''
        fecha_pago = DateTime.now.strftime("%d-%m-%Y")
        fecha_contable = DateTime.now.strftime("%d-%m-%Y")
      else  
        fecha_pago     = params[:income][:fecha_pago]
        fecha_contable = params[:income][:fecha_contable]
      end
      workplace = Workplace.where(id:params[:income][:workplace_id]).first

      @income = Income.new
      @income.monto       =  params[:income][:monto]
      @income.person_id   =  params[:income][:person_id]
      @income.workplace_id=  params[:income][:workplace_id]
      @income.office_id   =  workplace.office_id
      @income.tipo        = "Incompleta"
      @income.user_id     =  params[:income][:user_id]
      @income.document    =  params[:income][:document]
      @income.banco       =  params[:income][:banco]
      @income.mediopago   =  params[:income][:mediopago]
      @income.fecha_pago  =  Date.parse(fecha_pago)
      @income.fecha_contable  = Date.parse( fecha_contable)
      @income.mes_cuota   = ""
      @income.fecha       =  DateTime.now
      @income.estado      = "CONFIRMADO"

      @income.save

      
      @persondocuments = Persondocument.all

      if current_user.rut ==   @income.person.rut
        redirect_to dashboard_index_path
      else
        redirect_to person_path(params[:income][:person_id])
      end
    end
  end

  def error_pay
    @msg = params[:msg] 
  end  

  def senduser
    users = Person.where( rut: ['14103369-7','12212569-6','6728168-3','7525652-3','11825249-7','8055506-7','5591066-9','6460909-2','12690706-0','10544097-9','13069397-0','6157085-3','8263904-7','6504308-4','7034287-1','15217726-7','4269924-1','6653259-3','10543350-6','8622387-2','7068787-9','8263053-8','6793711-2','13169430-K','7906858-6','11691652-5','13125329-K','5615757-3'])
    users.each do |user|
      user.password = "#{user.rut}"
      user.password_confirmation = "#{user.rut}"
      user.save
    end
  end  

  def enviar
    #users = User.where.not(email: nil )
    users = User.where(email: "marragni@gmail.com")

    @c = 0
    @e = 0

    users.each do |user|
      if !user.email.include? "sin" 
        begin
          if c >=506
            PersonMailer.send_news(user.email).deliver
            @c=@c+1
          end  
        rescue
          puts "******************"
          puts "******************"
          puts user.rut
          puts user.email
          puts "******************"
          puts "******************"
          @e=@e+1
        end  
      end
    end
  end

  private
    def set_person
      @person = Person.find(params[:id])
    end

    def person_params
      params.require(:person).permit( :email, :rut, :created_at, :updated_at, :picture, :phone, :terms, :fechaterms, :completeeduc, :nombres, :nro_registro, :apellido_paterno, :apellido_materno, :sexo, :nacionalidad, :fecha_inscripcion, :direccion, :ciudad, :universidad, :fecha_titulo, :lugar_trabajo, :tipo_contrato, :workplace_id, :forma_pago, :telefono, :celular, :certificado_file )
    end
    def income_params
      params.require(:income).permit( :fees, :fecha, :tipo, :person_id, :workplace_id, :user_id, :monto , :banco, :mediopago, :document )
    end

 
end
