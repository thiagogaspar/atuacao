class Applicant < ActiveRecord::Base
  # Validations
  validates :name, :email, :phone_1, :address, :confirm, presence: true, unless: :new_record?
  validates :email, uniqueness: true
  validates :confirmation_token, uniqueness: true

  # Carrierwave uploader
  mount_uploader :confirm, ConfirmUploader
end
