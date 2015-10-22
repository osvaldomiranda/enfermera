class RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    # add custom create logic here
    
    user = User.new
    user.email = params[:user][:email]
    user.password = params[:user][:password]
    user.password_confirmation = params[:user][:password_confirmation]
    user.save

    person = Person.new
    person.email = params[:user][:email]
    person.save

    spouse = Spouse.new
    spouse.person_id = person.id
    spouse.save

    dependent = Dependent.new
    dependent.person_id = person.id
    dependent.save

    ingreso = Ingreso.new
    ingreso.person_id = person.id
    ingreso.save

    deuda_directum = DeudaDirectum.new
    deuda_directum.person_id = person.id
    deuda_directum.save

    deuda_indirectum = DeudaIndirectum.new
    deuda_indirectum.person_id = person.id
    deuda_indirectum.save

    sign_in(user)

    render "home/index"
  end

  def update
    super
  end
end 