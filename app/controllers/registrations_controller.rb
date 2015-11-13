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

    sign_in(user)

    render "home/index"
  end

  def update
    super
  end
end 