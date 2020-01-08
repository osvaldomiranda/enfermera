class InscriptionsController < ApplicationController
  before_filter :authenticate_user! , only: [:index, :edit, :update, :destroy, :change_state]
  before_action :set_inscription, only: [:show, :edit, :update, :destroy, :change_state]

  respond_to :html

  def index
    if params["/people"].present?
      @apellido_paterno = params["/people"][:apellido_paterno]
      @apellido_materno = params["/people"][:apellido_materno]
      @rut = params["/people"][:rut] || nil
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
    @inscriptions = Inscription.office(office_id).with_estado(@estado).workplace(@lugar_trabajo).with_paterno(@apellido_paterno).with_materno(@apellido_materno).with_rut(@rut).order(created_at: :desc).page(params[:page]).per_page(20)  

    respond_with(@inscriptions)
  end

  def change_state
    if params[:change_state].present?
      @inscription.estado = params[:change_state]
      @inscription.user_id = current_user.id
      if @inscription.save
        if @inscription.estado = "APROBADA"
          @inscription.create_person_user
        end
      end
    end

    if params["/people"].present?
      @apellido_paterno = params["/people"][:apellido_paterno]
      @apellido_materno = params["/people"][:apellido_materno]
      @rut = params["/people"][:rut] || nil
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
    @inscriptions = Inscription.office(office_id).with_estado(@estado).workplace(@lugar_trabajo).with_paterno(@apellido_paterno).with_materno(@apellido_materno).with_rut(@rut).order(created_at: :desc).page(params[:page]).per_page(20)  

    render 'inscriptions/index'
  end

  def show
    respond_with(@inscription)
  end

  def new
    @valorcuota = Currentfee.last.valor
    @inscription = Inscription.new
    respond_with(@inscription)
  end

  def edit
  end

  def create
    inscription_params[:email] = "#{inscription_params[:rut]}sin@email.cl" unless inscription_params[:email].present?
    
    @inscription = Inscription.new(inscription_params)
    @inscription.save
    respond_with(@inscription)
  end

  def update
    @inscription.update(inscription_params)
    respond_with(@inscription)
  end

  def destroy
    @inscription.destroy
    respond_with(@inscription)
  end

  def prueba

    ruts = ['15952760', '17936479', '18275460', '16203522', '18582018', '15519091', '15587709', '15571930', '19052562', '12988843', '18299369', '12710307', '17400829', '13675783', '15551386', '17919428', '18375010', '15396618', '16085941', '14164115', '17363996', '15234633', '9793025',  '15331698', '15132903', '16369501', '13529518', '15878015', '15907548', '15557300', '13420015', '18571730', '18081617', '15560028', '17882218', '15761470', '16494228', '17290041', '12436150', '15766154', '12661923', '16999823', '18800729', '167798667',  '18178689', '12519869', '17584806', '10296499', '18680671', '16393868', '17863411', '16971187', '18375837', '15660772', '18191529', '18116423', '17483147', '10710723', '14483778', '16312516', '16863560', '8959760',  '17754395', '17736438', '19370050', '18260252', '18355015', '19084026', '13198277', '18590453', '18862831', '18452035', '18804803', '11615032', '17974567', '16634298', '15947400', '17645076', '18841897', '16441677', '10604238', '18034922', '25413714', '16517163', '18194961', '16152256', '18430579', '18260040', '26998985', '18805491', '18393990', '15996201', '17910313', '18804390', '18199637', '16438454', '17448882', '15828390', '17594814', '15006776', '18042265', '17061378', '18244070', '13639474', '17613422', '16807079', '13584248']
    ruts.map{|r| [r,Inscription.certificado(r)]}   

    @inscription = Inscription.new
    respond_with(@inscription)
  end

  private
    def set_inscription
      if params[:id].present?
        @inscription = Inscription.find(params[:id])
      end  
    end

    def inscription_params
      params.require(:inscription).permit(:nro_registro, :rut, :nombres, :apellido_paterno, :apellido_materno, :sexo, :nacionalidad, :fecha_inscripcion, :direccion, :ciudad, :universidad, :fecha_titulo, :tipo_contrato, :estado, :fecha_solicitud, :workplace_id, :forma_pago, :email, :password, :password_confirmation, :telefono, :celular, :origen, :pais_origen, :change_state)
    end
end
