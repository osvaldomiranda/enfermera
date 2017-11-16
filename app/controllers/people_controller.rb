class PeopleController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_person, only: [:show, :edit, :cancel, :update, :destroy, :picture, :terms, :termstopdf, :payregister, :certificado]

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
    @msg = Workplace.import_email(params[:file]).force_encoding('utf-8')
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
    @income = Income.new
    respond_modal_with(@income)
  end

  def pay

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
    @income.mes_cuota   = params[:income][:mes_cuota]
    @income.fecha       =  DateTime.now
    @income.estado      = "CONFIRMADO"

    if @income.save
      
      mes = params[:income][:mes_cuota][0..1].gsub('-','').to_i
      year = params[:income][:mes_cuota][2..6].gsub('-','').to_i      

     
      valorcuota = Currentfee.last.valor 
    
      if (year == 2016) 
        valorcuota = 6000 
      end
      if (year == 2018 ) 
        valorcuota = 7000 
      end


      n = params[:income][:monto].to_i/valorcuota
      if (n<1) 
        n=1
      end
      

      @person = Person.find(params[:income][:person_id])
      (1..n).each do |i|
        fee = Fee.new
        fee.rut = @person.rut
        fee.email = @person.email
        fee.fecha_pago = Date.parse(fecha_pago)
        fee.mes = i
        fee.monto = valorcuota
        fee.mes_cuota = "#{mes}-#{year}"
        fee.person_id = @person.id

        if current_user.role?(:finance)
          fee.pagador = "Pago Registrado Admin"
          fee.estado = "Confirmado"
        else
          fee.pagador = "Pago Directo Colegiada"
          fee.estado = "Por Confirmar"
        end
        
        fee.income_id = @income.id
        fee.save

        mes += 1
        if mes > 12
          mes = mes-12
          year = year+1
        end
      end
    end

    @persondocuments = Persondocument.all

    if current_user.rut ==   @income.person.rut
      redirect_to dashboard_index_path
    else
      redirect_to person_path(params[:income][:person_id])
    end
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
    users = User.where.not(email: nil )
    #users = User.where(email: "marragni@gmail.com")

    

    @c = 0
    @e = 0

    users.each do |user|
      if !user.email.include? "sin" 
        begin
          PersonMailer.send_news(user.email).deliver
          @c=@c+1
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
      params.require(:income).permit( :fecha, :tipo, :person_id, :workplace_id, :user_id, :monto , :banco, :mediopago, :document )
    end

 
end
