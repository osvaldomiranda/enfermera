class IncompletePayController < ApplicationController
  def index
    @people = Person.withincompletepay
  end

  def fee_register
    @person = Person.where(id: params[:id]).first
    if @person.present?
      @fees = @person.fees.where(pagador: "Incompleta")
      @incomes = Income.where(person_id: @person.id, tipo: "Incompleta")
    end
  end

  def register
  end
end
