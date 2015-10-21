class DocumentsController < ApplicationController
  before_action :set_document, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @person = Person.where(email: current_user.email)
    @documents = Document.all
    respond_with(@documents)
  end

  def show
    respond_with(@document)
  end

  def new
    @document = Document.new
    respond_modal_with(@document)
  end

  def edit
  end

  def create
    person = Person.find_by_email(current_user.email)
    @document = Document.new(document_params)
    @document.person_id = person.id
    @document.save

    @documents = Document.all
    render "index"
  end

  def update
    @document.update(document_params)
    respond_with(@document)
  end

  def destroy
    @document.destroy
    respond_with(@document)
  end

  private
    def set_document
      @document = Document.find(params[:id])
    end

    def document_params
      params.require(:document).permit(:name, :file, :person_id)
    end
end
