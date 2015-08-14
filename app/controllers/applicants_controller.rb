#encoding: utf-8

class ApplicantsController < ApplicationController
  before_action :set_applicant, only: [:show, :edit, :update, :destroy]
  before_action :validate_token, only: [:new]
  before_action :authorize, only: [:index, :destroy]

  def index
    @applicants = Applicant.all
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    @applicant = Applicant.new(applicant_params)

    if @applicant.save
      @applicant.update_attribute(:expired, true)
      redirect_to @applicant, notice: 'Participante criado com sucesso.'
    else
      render :new
    end
  end

  def update
    if @applicant.update(applicant_params)
      @applicant.update_attribute(:expired, true)
      redirect_to @applicant, notice: 'Você foi cadastrado com sucesso.'
    else
      render :edit
    end
  end

  def destroy
    @applicant.destroy
    redirect_to applicants_url, notice: 'Participante excluído.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_applicant
      @applicant = Applicant.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def applicant_params
      params.require(:applicant).permit(:name, :email, :phone_1, :phone_2, :confirm, :address)
    end

    def validate_token
      @applicant = Applicant.where(confirmation_token: params[:token]).first
      
      if @applicant.blank? || @applicant.expired?
        redirect_to login_url, notice: "Código de cadastro expirado."
      end
    end
end
