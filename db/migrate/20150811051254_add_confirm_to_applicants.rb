class AddConfirmToApplicants < ActiveRecord::Migration
  def change
    add_column :applicants, :confirm, :string
  end
end
