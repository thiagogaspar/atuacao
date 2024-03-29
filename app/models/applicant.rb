class Applicant < ActiveRecord::Base
  # Validations
  validates :name, :email, :last_name, :phone_1, :address, presence: true, unless: :new_record?
  validates :email, uniqueness: true
  validates :confirmation_token, uniqueness: true

  # Carrierwave uploader
  mount_uploader :confirm, ConfirmUploader
end
