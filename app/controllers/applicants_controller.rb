#encoding: utf-8

class ApplicantsController < ApplicationController
  before_action :set_applicant, only: [:show, :edit, :destroy]
  before_action :set_applicant_by_token, only: [:confirm, :subscribe]
  before_action :validate_token, only: [:confirm, :subscribe]
  before_action :authorize, except: [:confirm, :subscribe] 

  def index
    @applicants = Applicant.all
  end

  def show
  end

  def new
  end

  def edit
    @url = applicant_path(params[:id])
    @method = "patch"
  end

  def create
    @applicant = Applicant.new(applicant_params)
  end

  def update
    respond_to do |format|
      if @applicant.update(applicant_params)
        @applicant.update_attribute(:expired, true)
        
        format.html { render :index }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @applicant.destroy
    redirect_to applicants_url, notice: 'Participante excluído.'
  end

  def confirm
    @url = subscribe_path(params[:token])
    @method = :post
  end

  def subscribe
    respond_to do |format|
      if @applicant.update(applicant_params)
        @applicant.update_attribute(:expired, true)
        @success = true
        
        format.html
      else
        @success = false
        format.html { redirect_to confirm_path(params[:token]), :flash => { :error => @applicant.errors.full_messages.join(', ') } } 
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_applicant
      @applicant = Applicant.find(params[:id])
    end

    def set_applicant_by_token
      @applicant = Applicant.find_by(confirmation_token: params[:token])
    end

    # Only allow a trusted parameter "white list" through.
    def applicant_params
      params.require(:applicant).permit(:name, :last_name, :email, :phone_1, :organization, :confirm, :address)
    end

    def validate_token
      @applicant = Applicant.find_by(confirmation_token: params[:token])
      
      if @applicant.blank? || @applicant.expired?
        redirect_to login_url, notice: "Código de cadastro expirado."
      end
    end
end
