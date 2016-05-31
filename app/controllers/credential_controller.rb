class CredentialController < ApplicationController
  before_filter :authenticate_user!  

  require 'barby'
  require 'barby/barcode/ean_13'
  require 'barby/outputter/html_outputter'

  respond_to :html
  def index
     @person = Person.where(rut:current_user.rut).first

     @barcode = Barby::EAN13.new('000113671769')

     @barcode_for_html = Barby::HtmlOutputter.new(@barcode)

     respond_modal_with(@person)
  end
end
