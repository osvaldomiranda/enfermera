class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.role? :admin
      can :manage, :all
      can :login, User
    elsif user.role? :observer
      can :read, :all
    # elsif user.role? :realtor
    #   can :reservation, Reserva
    # elsif user.role? :logistics
    #   can :manage, Reserva
    #   can [:create, :read, :update, :upload, :edit ], Proyecto
    #   can :manage, :logistica
    # elsif user.role? :logistics_admin  
    #   can :destroy, Proyecto
    # elsif user.role? :promise
    #   can :manage, promise
    # elsif user.role? :invoice
    #   can :manage, Invoice
    # elsif user.role? :invoice_admin  
    #   can :manage, Invoice      
    end
  end
end