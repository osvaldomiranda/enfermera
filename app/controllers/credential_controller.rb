class CredentialController < ApplicationController
  respond_to :html
  def index
  	 @person = Person.where(email:current_user.email).first
  	 respond_modal_with(@person)
  end
end
